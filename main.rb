require_relative './src/models/user'
require_relative './src/models/event'
require_relative './src/models/event_storage'
require_relative './src/controllers/user_controller'
require_relative './src/controllers/event_controller'

puts "Welcome to the City Event Notification System!"

user_controller = UserController.new

print "Enter your name: "
name = gets.chomp
print "Enter your email: "
email = gets.chomp
print "Enter your city: "
city = gets.chomp

user_controller.register(name, email, city)

events = EventStorage.load(user_controller.all_users)
event_controller = EventController.new(events, user_controller)

loop do
  puts "\n1. Create Event\n2. List Events\n3. Join Event\n4. Cancel Participation\n5. My Events\n6. Events Happening Now\n7. Past Events\n8. Exit"
  print "Choose an option: "
  option = gets.chomp.to_i

  case option
  when 1
    print "Event name: "
    name = gets.chomp
    print "Address: "
    address = gets.chomp
    puts "Categories: #{Event::CATEGORIES.join(', ')}"
    print "Category: "
    category = gets.chomp
    print "Date and Time (YYYY-MM-DD HH:MM): "
    datetime = DateTime.parse(gets.chomp)
    print "Description: "
    description = gets.chomp
    event_controller.create_event(name, address, category, datetime, description)
  when 2
    event_controller.list_events.each_with_index do |e, i|
      puts "#{i + 1} - #{e.name} (#{e.category}) - #{e.datetime.strftime('%d/%m %H:%M')}"
    end
  when 3
    print "Event number to join: "
    index = gets.chomp.to_i - 1
    event_controller.confirm_participation(index)
  when 4
    print "Event number to cancel: "
    index = gets.chomp.to_i - 1
    event_controller.cancel_participation(index)
  when 5
    puts "Your confirmed events:"
    event_controller.my_events.each { |e| puts "#{e.name} on #{e.datetime.strftime('%d/%m %H:%M')}" }
  when 6
    puts "Events happening now:"
    event_controller.happening_now.each { |e| puts "#{e.name} is happening now!" }
  when 7
    puts "Past events:"
    event_controller.past_events.each { |e| puts "#{e.name} happened on #{e.datetime.strftime('%d/%m %H:%M')}" }
  when 8
    event_controller.save
    puts "Exiting the system. Goodbye!"
    break
  end
end
