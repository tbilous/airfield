require 'rails_helper'

RSpec.describe PlainsController, type: :controller do
  describe '#index' do
    subject { get :index }

    let(:plains) { Plain.init }

    before do
      plains
      subject
    end

    it { expect(response.body).to have_json_size(5).at_path('plains') }
  end

  describe '#take_off' do
    subject { post :take_off, params: { plain_id: plain.id.to_s } }

    let(:plain) { Plain.create }

    before do
      subject
    end

    it { expect(response.status).to eq 201 }
  end
end
