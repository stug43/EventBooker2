require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do 
    @user = User.create(first_name: "John", last_name: "Doe", description: "This user is purely for testings. Do not expect him to be real or to be your type.", email: "abcd@efg.hi", encrypted_password: "crypted")
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
      expect(@user).to be_valid
    end

    describe "#first_name" do
      it "should not be valid without first_name" do
        bad_user = User.create(last_name: "Doe", description: "This user is purely for testings. Do not expect him to be real or to be your type.", email: "abcd@efg.hi", encrypted_password: "crypted")
        expect(bad_user).not_to be_valid
        # test très sympa qui permet de vérifier que la fameuse formule user.errors retourne bien un hash qui contient une erreur concernant le first_name. 
        expect(bad_user.errors.include?(:first_name)).to eq(true)
      end
    end

    describe "#last_name" do
      it "should not be valid without last_name" do
        bad_user = User.create(first_name: "John", description: "This user is purely for testings. Do not expect him to be real or to be your type.", email: "abcd@efg.hi", encrypted_password: "crypted")
        expect(bad_user).not_to be_valid
        expect(bad_user.errors.include?(:last_name)).to eq(true)
      end
    end

    describe "#description" do
      it "should not be lower that 10 characters" do
        invalid_user = User.create(first_name: "John", last_name: "Doe", description: "okokok", email: "abdc@efg.hi", encrypted_password: "crypted")
        expect(invalid_user).not_to be_valid
        expect(invalid_user.errors.include?(:description)).to eq(true)
      end
    end

  end

  context "associations" do

    describe "events" do
      it "should have_many events" do
        event = Event.create(admin: @user, start_date: (Time.now+6000).to_date, title: "titre de l'evenement", price: 280, location: "Toulouse", duration: 256)
        expect(@user.events.include?(event)).to eq(true)
      end
    end

		describe "attendees" do
      it "should have_many attendees" do
        event = Event.create(admin: @user, start_date: (Time.now+6000).to_date, title: "titre de l'evenement", price: 280, location: "Toulouse", duration: 256)
				attendance = Attendance.create(attendee: @user, event: event, stripe_customer_id: "okokook")
        expect(@user.attendees.include?(@user)).to eq(true)
      end
    end

  end

end
