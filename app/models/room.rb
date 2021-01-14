class Room < ApplicationRecord
  DEFAULT_NAME = 'general'.freeze

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  class << self
    def default_room
      Room.find_or_create_by!(name: DEFAULT_NAME)
    end
  end
end
