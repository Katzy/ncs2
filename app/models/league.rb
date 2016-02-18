class League < ActiveRecord::Base

  has_many :schools
  has_one :user

  validates :name, presence: true
  validates_uniqueness_of :name

end