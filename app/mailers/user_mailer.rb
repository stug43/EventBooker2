class UserMailer < ApplicationMailer
	default from: 'no_reply@ngEventBooker.com'

	def welcome_email(user)
		@user = user
		@url = "https://ng_EventBooker.herokuapp.com"
		mail(to: @user.email, subject: 'ng_EventBooker te souhaite la bienvenue !')
	end
end
