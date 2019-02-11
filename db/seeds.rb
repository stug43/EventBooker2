User.destroy_all
Event.destroy_all
Attendance.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

20.times do |index|
	user = FactoryBot.create(:user)
end

35.times do |index|
	event = FactoryBot.create(:event)
end

45.times do |index|
	attendance = FactoryBot.create(:attendance)
end
