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

    category = nil
    loop do
      print "Category: "
      input = gets.chomp
      if Event::CATEGORIES.include?(input)
        category = input
        break
      else
        puts "Invalid category. Choose one of: #{Event::CATEGORIES.join(', ')}"
      end
    end

    datetime = nil
    loop do
      print "Date and Time (YYYY-MM-DD HH:MM): "
      input = gets.chomp
      begin
        datetime = DateTime.parse(input)
        break
      rescue ArgumentError
        puts "Invalid date format. Please use 'YYYY-MM-DD HH:MM'."
      end
    end

    print "Description: "
    description = gets.chomp
    event_controller.create_event(name, address, category, datetime, description)

  when 2
    events = event_controller.list_events
    if events.empty?
      puts "No events registered."
    else
      events.each_with_index do |e, i|
        puts "#{i + 1} - #{e.name} (#{e.category}) - #{e.datetime.strftime('%d/%m %H:%M')}"
      end
    end

  when 3
    events = event_controller.list_events
    events.each_with_index do |e, i|
      puts "#{i + 1} - #{e.name} (#{e.category}) - #{e.datetime.strftime('%d/%m %H:%M')}"
    end
    print "Event number to join: "
    index = gets.chomp.to_i - 1
    if index >= 0 && index < events.size
      event_controller.confirm_participation(index)
    else
      puts "Invalid event number."
    end

  when 4
    my_events = event_controller.my_events
    my_events.each_with_index do |e, i|
      puts "#{i + 1} - #{e.name} on #{e.datetime.strftime('%d/%m %H:%M')}"
    end
    print "Event number to cancel: "
    index = gets.chomp.to_i - 1
    if index >= 0 && index < my_events.size
      event = my_events[index]
      event_index = event_controller.list_events.index(event)
      event_controller.cancel_participation(event_index)
    else
      puts "Invalid event number."
    end

  when 5
    puts "Your confirmed events:"
    event_controller.my_events.each { |e| puts "#{e.name} on #{e.datetime.strftime('%d/%m %H:%M')}" }

  when 6
    puts "Events happening now:"
    events = event_controller.happening_now
    if events.empty?
      puts "No events are happening now."
    else
      events.each { |e| puts "#{e.name} is happening now!" }
    end

  when 7
    puts "Past events:"
    events = event_controller.past_events
    if events.empty?
      puts "No past events."
    else
      events.each { |e| puts "#{e.name} happened on #{e.datetime.strftime('%d/%m %H:%M')}" }
    end

  when 8
    event_controller.save
    puts "Exiting the system. Goodbye!"
    break

  else
    puts "Invalid option. Please choose a number between 1 and 8."
  end
end
