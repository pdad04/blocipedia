class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis
  has_many :wikis, through: :collaborators

  after_initialize { self.role ||= :standard }

  enum role: [:admin, :standard, :premium]

  def premium_to_standard
    self.standard!
    make_wikis_public
  end

  def make_wikis_public
    self.wikis.each do |w|
      w.update_attribute(:private, false)
    end
  end

end
