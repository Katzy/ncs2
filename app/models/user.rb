class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :school
  belongs_to :league

  validates :name, presence: true

  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true

#   def self.to_csv(options = {})
#     CSV.generate(options) do |csv|
#       csv << ["school", "Section", "Coach", "Phone", "Email"]
#       all.each do |user|
#         csv << [user.school, user.section, user.name, user.cell, user.email]
#       end
#     end
#   end
# end

end
