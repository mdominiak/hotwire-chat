class Message < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :room

  broadcasts_to :room

  validates :author, :room, :content, presence: true

  def edited?
    created_at != updated_at
  end
end
