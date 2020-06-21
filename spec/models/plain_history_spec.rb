require 'rails_helper'

RSpec.describe PlainHistory, type: :model do
  it { is_expected.to have_timestamps.for(:creating) }
  it { is_expected.to belong_to(:plain) }
end
