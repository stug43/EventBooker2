require 'rails_helper'

RSpec.describe Event, type: :model do

  before(:each) do 
		@user = FactoryBot.create(:user)
		@event = Event.create(admin: @user, start_date: (Time.now + 6000).to_date, duration: 250, price: 290, title: "Titredel'Event", description: "description description description description description description description description description description description description description description description description description description description description description description description ", location: "Marseille")
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@event).to be_a(Event)
      expect(@event).to be_valid
    end

    describe "#start_date" do
      it "should not be valid without start_date" do
        bad_event = Event.create(admin: @user, duration: 250, price: 290, title: "Titrede l'Event", description: "description description description description description description description description description description description description description description description description description description description description description description description description ", location: "Marseille")
        expect(bad_event).not_to be_valid
        # test très sympa qui permet de vérifier que la fameuse formule user.errors retourne bien un hash qui contient une erreur concernant le first_name. 
        expect(bad_event.errors.include?(:start_date)).to eq(true)
      end
    end

    describe "#title" do
      it "should not be valid without last_name" do
        bad_event = Event.create(start_date: (Time.now+6000).to_date, duration: 250, price: 290, description: "description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description description ", location: "Marseille")
        expect(bad_event).not_to be_valid
        expect(bad_event.errors.include?(:title)).to eq(true)
      end
    end

    describe "#description" do
      it "should not be lower that 30 characters" do
				invalid_event = Event.create(start_date: (Time.now+6000).to_date, duration: 250, price: 290, description: "description description", location: "Marseille")
        expect(invalid_event).not_to be_valid
        expect(invalid_event.errors.include?(:description)).to eq(true)
      end
    end

  end

  context "associations" do

    describe "attendance" do
      it "should have_many attendances" do
				attendance = Attendance.create(attendee: @user, event: @event, stripe_customer_id: "okokok")
        expect(@event.attendances.include?(attendance)).to eq(true)
      end
    end

		 describe "attendee" do
      it "should have_many attendees" do
        attendance = Attendance.create(attendee: @user, event: @event, stripe_customer_id: "okokok")
        expect(@event.attendees.include?(@user)).to eq(true)
      end
    end

  end

end
