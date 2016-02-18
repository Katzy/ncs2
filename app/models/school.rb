class School < ActiveRecord::Base

  belongs_to :league
  has_many :wrestlers
  has_many :users

  validates :name, presence: true
  validates_uniqueness_of :name

end