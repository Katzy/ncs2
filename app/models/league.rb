class League < ActiveRecord::Base
  acts_as_xlsx
  
  has_many :schools
  has_many :wrestlers
  has_many :users

  validates :name, presence: true
  validates_uniqueness_of :name

end

