require 'rails_helper'

describe Message, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:room) }
  end
end
