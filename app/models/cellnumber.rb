class Cellnumber < ActiveRecord::Base

  validates :cell, presence: true, null: false
  validates :carrier_name, presence: true, null: false

  validates_uniqueness_of :cell

end