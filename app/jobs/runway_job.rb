class RunwayJob < ApplicationJob
  queue_as :runway

  def perform(id)
    plain = Plain.find_by(id: id)
    return unless plain.taxiway?

    sleep((10..20).to_a.sample)

    plain.fly
  rescue Mongoid::Errors::DocumentNotFound => e
    puts e
  end
end
