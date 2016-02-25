class Alert < ActiveRecord::Base

  validates :message, presence: true, null: false

end