class AttendancesController < ApplicationController

	def index
		@event = Event.find(params[:event_id])
	end

  def new
		@event = Event.find(params[:event_id])
		@striprice = @event.price*100
		@attendance
  end

  def create
		@event = Event.find(params[:event_id])
		@striprice = @event.price*100

		customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @striprice,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

		rescue Stripe::CardError => e
  		flash[:error] = e.message
  		redirect_to new_event_attendance_path(@event)
		
		if customer&&charge
			att = Attendance.create(attendee: current_user, event: @event, stripe_customer_id: charge.customer)
			redirect_to root_path
		else
			redirect_to new_event_attendance_path(@event)
		end

  end

  def destroy
  end
end
