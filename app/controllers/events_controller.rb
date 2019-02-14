class EventsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def show
		@event = Event.find(params[:id])
  end

  def new
  end

  def create
		e = Event.new(title: params[:title], duration: params[:duration].to_i, price: params[:price].to_i, start_date: Date.parse(params[:start_date]), location: params[:location], description: params[:description])
		e.admin = current_user
		if e.save
			redirect_to event_path(e)
		else
			redirect_to new_event_path
		end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
