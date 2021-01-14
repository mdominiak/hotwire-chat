require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'validations' do
    subject { described_class.new(name: 'general') }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'class methods' do
    describe '.default_room' do
      subject { described_class.default_room }

      it 'create new default room' do
        expect { subject }.to change { Room.count }
        Room.last.tap do |room|
          expect(room.name).to eq Room::DEFAULT_NAME
        end
      end

      it 'returns default room' do
        subject.tap do |room|
          expect(room).to eq Room.find_by!(name: Room::DEFAULT_NAME)
        end
      end

      context 'default room exists' do
        let!(:default_room) { Room.create!(name: Room::DEFAULT_NAME) }

        it 'does not create new room' do
          expect { subject }.to_not change { Room.count }
        end

        it 'returns existing default room' do
          subject.tap do |room|
            expect(room).to eq Room.find_by!(name: Room::DEFAULT_NAME)
          end
        end
      end
    end
  end
end
