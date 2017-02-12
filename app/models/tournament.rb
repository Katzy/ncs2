class Tournament < ActiveRecord::Base

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