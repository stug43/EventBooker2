class Attendance < ApplicationRecord
	after_create :confirm_send

	belongs_to :attendee, class_name: "User"
	belongs_to :event
	validates :stripe_customer_id, presence: true

	def confirm_send
		AttendanceMailer.attendee_confirm_email(self).deliver_now
	end
end
