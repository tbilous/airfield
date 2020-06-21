module Flyable
  extend ActiveSupport::Concern

  included do
    state_machine initial: :hangar do
      event :hangar

      event :taxiway do
        transition hangar: :taxiway
      end

      event :fly do
        transition taxiway: :fly
      end

      # rubocop:disable Style/SymbolProc
      before_transition any => :taxiway do |plain|
        plain.proceed_runway
      end
      # rubocop:enable Style/SymbolProc

      after_transition any => any do |plain|
        plain.send(:write_history)
        plain.broadcast
      end
    end

    def broadcast
      json = broadcast_serialize
      ActionCable.server.broadcast "plain_#{json['id']}", json
      # ActionCable.server.broadcast "plain_#{json.dig('id')}", json
    end

    def broadcast_serialize
      { id: id.to_s, state: state,
        history: plain_histories.map do |i|
          { id: i.id.to_s, state: i.state, created: i.created_at.to_formatted_s(:short) }
        end }.as_json
    end

    def proceed_runway
      RunwayJob.perform_later(id.to_s)
    end
  end
end
