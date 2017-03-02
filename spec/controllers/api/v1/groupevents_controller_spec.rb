require 'rails_helper'

RSpec.describe Api::V1::GroupeventsController do
  let(:listing) { create :groupevent }

  before do
    allow(Groupevent).to receive(:find).with('1').and_return listing
    allow(Groupevent).to receive(:find).with('2').and_return nil
  end


  describe 'GET #show' do
    context 'When success' do
      before do
        get :show, { id: 1 }
      end

      it 'returns success response' do
        expect(response).to be_success
        expect(response.body).to eq({
          status: 'OK',
          group_event: listing
        }.to_json)
      end
    end

    context 'When failure' do
      before do
        get :show, { id: 2 }
      end

      it 'returns error response' do
        expect(response.status).to eq 200
      end
    end
  end

end