class Message < ApplicationRecord
  belongs_to :author
  belongs_to :room

  validates :author, :room, :content, presence: true
end
