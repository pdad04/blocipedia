class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  
  validates :title, :body, presence: true
  validates :title, length: { minimum: 3 }
  validates :body, length: { minimum: 10 }

end
