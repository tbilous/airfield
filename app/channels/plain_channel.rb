class PlainChannel < ApplicationCable::Channel
  def subscribed
    reject if params['id'].blank?
    plain = Plain.find_by(id: params['id'])
    reject unless plain

    stream_from "plain_#{plain&.id}"
  rescue Mongoid::Errors::DocumentNotFound
    reject
  end
end
