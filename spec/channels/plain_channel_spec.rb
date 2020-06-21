require 'rails_helper'

RSpec.describe PlainChannel, type: :channel do
  let(:plain) { Plain.create }

  context 'params is wring' do
    it 'rejects when no id provided' do
      subscribe
      expect(subscription).to be_rejected
    end
  end

  context 'params is right' do
    before { subscribe(plain_id: plain.id.to_s) }

    it 'subscribes to plain stream when id provided' do
      expect(subscription).to be_confirmed
    end

    it 'plain stream when id provided' do
      expect(subscription).to have_stream_from("plain_#{plain.id}")
    end
  end
end
