require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do 
		@user = FactoryBot.create(:user)
		@event = FactoryBot.create(:event)
		@attendance = Attendance.create(attendee: @user, event: @event, stripe_customer_id: "okokok")
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@attendance).to be_a(Attendance)
      expect(@attendance).to be_valid
    end

    describe "#stripe_customer_id" do
      it "should not be valid without stripe_customer_id" do
        bad_attendance = Attendance.create(attendee: @user, event: @event)
        expect(bad_attendance).not_to be_valid
        # test très sympa qui permet de vérifier que la fameuse formule user.errors retourne bien un hash qui contient une erreur concernant le first_name. 
        expect(bad_attendance.errors.include?(:stripe_customer_id)).to eq(true)
      end
    end

    describe "#event" do
      it "should not be valid without an event" do
        bad_attendance = Attendance.create(attendee: @user, stripe_customer_id: "okokok")
        expect(bad_attendance).not_to be_valid
        expect(bad_attendance.errors.include?(:event)).to eq(true)
      end
    end

    describe "#attendee" do
      it "should not be valid without an attendee" do
        invalid_attendance = Attendance.create(event: @event, stripe_customer_id: "okokok")
        expect(invalid_attendance).not_to be_valid
        expect(invalid_attendance.errors.include?(:attendee)).to eq(true)
      end
    end

  end

  context "associations" do

    describe "event" do
      it "should belongs_to an event" do
        expect(@attendance.event).to eq(@event)
      end
    end

  end

end
