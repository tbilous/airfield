require 'rails_helper'

RSpec.describe Plain, type: :model do
  it { is_expected.to have_many(:plain_histories).with_dependent(:destroy) }
  it { is_expected.to validate_inclusion_of(:state).to_allow(Options::Plain::States.all) }

  describe '#write_history' do
    subject { described_class.create }

    it { expect { subject }.to change(PlainHistory, :count).by(1) }
  end
end
