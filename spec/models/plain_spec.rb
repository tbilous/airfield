require 'rails_helper'

RSpec.describe Plain, type: :model do
  it { is_expected.to have_many(:plain_histories).with_dependent(:destroy) }
end
