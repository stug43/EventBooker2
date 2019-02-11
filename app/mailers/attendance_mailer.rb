class AttendanceMailer < ApplicationMailer
	
	def attendee_confirm_email(attendance)
		@attendance = attendance
		
		mail(to: @attendance.event.admin.email, subject: "#{@attendance.attendee.first_name} #{@attendance.attendee.last_name} a rejoint #{@attendance.event.title}.")
	end

end
