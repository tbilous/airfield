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

      before_transition any => :taxiway do |plain|
        puts plain
      end

      after_transition any => any do |plain|
        plain.send(:write_history)
        plain.broadcast
      end
    end

    def broadcast
      json = broadcast_serialize
      ActionCable.server.broadcast "plain_#{json.dig('plain', 'id')}", json
    end

    def broadcast_serialize
      { plain:
          { id: id.to_s, state: state },
        plain_histories: plain_histories.map do |i|
          { id: i.id.to_s, created: i.created_at.to_formatted_s(:short) }
        end }.as_json
    end
  end
end
