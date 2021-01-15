require 'rails_helper'

describe User, type: :model do
  describe 'valid' do
    subject { described_class.new(name: 'matt') }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
