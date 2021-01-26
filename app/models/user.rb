class User < ApplicationRecord
  has_many :messages, foreign_key: :author_id
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
