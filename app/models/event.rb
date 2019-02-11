class Event < ApplicationRecord
require 'time'

	belongs_to :admin, class_name: "User"
	has_many :attendances
	has_many :attendees, through: :attendances
	validates :start_date, presence: true
	validate :future_start_date?
	validates :duration, presence: true, numericality: { only_integer: true, greater_than: 10 }
	validates :title, presence: true, length: { minimum: 5, maximum: 70 }
	validates :price, presence: true, numericality: { only_integer: true }
	validates :location, presence: true
	validates :description, presence: true, length: { minimum: 30 }

	private
	def future_start_date?
		start_date > Time.now
	end
end
