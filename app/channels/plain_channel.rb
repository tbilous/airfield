class PlainChannel < ApplicationCable::Channel
  def subscribed
    reject if params['plain_id'].blank?
    plain = Plain.find_by(id: params['plain_id'])
    reject unless plain

    stream_from "plain_#{plain&.id}"
  rescue Mongoid::Errors::DocumentNotFound
    reject
  end
end
