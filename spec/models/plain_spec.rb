require 'rails_helper'

RSpec.describe Plain, type: :model do
  it { is_expected.to have_many(:plain_histories).with_dependent(:destroy) }
  it { is_expected.to validate_inclusion_of(:state).to_allow(Options::Plain::States.all) }

  describe '#write_history' do
    subject { described_class.create }

    it { expect { subject }.to change(PlainHistory, :count).by(1) }
  end

  describe 'broadcast to channel' do
    let(:plain) { described_class.create }

    it 'changing state event should initialize broadcast to PlainChannel' do
      Options::Plain::States.all.drop(1).each do |state|
        expect { plain.send(state.to_sym) }.to have_broadcasted_to("plain_#{plain.id}").from_channel(PlainChannel)
      end
    end
  end
end
