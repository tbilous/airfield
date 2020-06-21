require 'rails_helper'

RSpec.describe AirfieldsController, type: :controller do
  describe '#show' do
    subject { get :show }

    before { subject }

    it { expect(response.status).to eq 200 }
  end

  describe '#init' do
    subject { post :init }

    it { expect { subject }.to change(Plain, :count).by(5) }
  end
end
