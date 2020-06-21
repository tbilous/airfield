class PlainChannel < ApplicationCable::Channel
  def subscribed(id)
    stream_from "plain_#{id}"
  end
end
