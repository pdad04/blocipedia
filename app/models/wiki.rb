class Wiki < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { minimum: 3 }
  validates :body, length: { minimum: 10 }

end
