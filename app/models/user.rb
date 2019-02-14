class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	after_create :welcome_send

	has_many :events, foreign_key: 'admin_id'
	has_many :attendees, through: :events
	has_many :attendances, foreign_key: 'attendee_id'
	validates :first_name, length: { minimum: 3 }, presence: true
	validates :last_name, length: { minimum: 3 }, presence: true
	validates :description, length: { minimum: 10 }, presence: true

	def welcome_send
		UserMailer.welcome_email(self).deliver_now
	end

	def full_name
		return (self.first_name.capitalize + " " + self.last_name.capitalize)
	end
end
