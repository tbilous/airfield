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
      end
    end
  end
end
