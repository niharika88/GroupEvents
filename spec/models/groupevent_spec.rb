require 'rails_helper'

describe Groupevent, type: :model do
  context 'validations' do
    it 'check name limits' do
      event = build(:groupevent, name: 'hello'*300)
      event.valid?
      expect(event.errors[:name]).to include('is too long (maximum is 255 characters)')
    end

    it 'check description limits' do
      event = build(:groupevent, description: 'hello'*65000)
      event.valid?
      expect(event.errors[:description]).to include('is too long (maximum is 500 characters)')
    end

    it 'check location limits' do
      event = build(:groupevent, location: 'hello'*300)
      event.valid?
      expect(event.errors[:location]).to include('is too long (maximum is 255 characters)')
    end

    it 'check if finish date is early than start date' do
      event = build(:groupevent, start_date: '01-01-2015', end_date: '01-01-2014')
      event.valid?
      expect(event.errors[:start_date]).to include I18n.t('groupevents.errors.finish_start_mismatch')
    end
  end

  context 'dates' do
    it 'calculate duration from finish and start dates' do
      event = create(:groupevent, start_date: '01-01-2015', end_date: '31-01-2015')
      expect(event.duration).to eq 31
    end

    it 'calculate finish from start date and duration' do
      event = create(:groupevent, start_date: '01-01-2015', duration: 31, end_date: nil)
      expect(event.end_date).to eq Date.parse('31-01-2015')
    end
  end

  context 'status' do
    it 'is default status draft' do
      event = create(:groupevent)
      expect(event.status).to eq "draft"
    end

    it 'changed to published when all fields exists' do
      event = create(:groupevent)
      event.publish!
      expect(event.publish!).to     be_truthy
      expect(event.status.to_sym).to eq :published
    end

    it 'raise exception when can not publish event with empty fields' do
      event = create(:groupevent, location: '')
      expect(event.publish!).to     be_falsey
    end
  end

  context 'destroy' do
    it 'is hide item only' do
      event = create_list(:groupevent, 5)
      event[1].destroy
      event[1].reload
      expect(event[1].deleted_at).to_not be_nil
      expect(Groupevent.count).to eq 5
    end
  end
end