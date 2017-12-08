class Season < ActiveRecord::Base
  has_many :season_wrestlers
  has_many :wrestlers, through: :season_wrestlers
  has_many :bouts
  validates :name, presence: true, null: false

end
