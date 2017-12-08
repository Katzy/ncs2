class SeasonWrestler < ActiveRecord::Base
  belongs_to :season
  belongs_to :wrestler
  belongs_to :school
end
