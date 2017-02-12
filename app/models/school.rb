class School < ActiveRecord::Base
  acts_as_xlsx

  belongs_to :league
  has_many :wrestlers
  has_many :users

  validates :name, presence: true
  validates_uniqueness_of :name

  def self.present_all
    self.all.map { |item| item.present }
  end

  def present
    { name: name,
      id: id
    }
  end

end