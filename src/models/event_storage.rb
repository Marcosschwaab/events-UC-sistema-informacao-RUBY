require 'json'

module EventStorage
  FILE_NAME = 'events.data'

  def self.save(events)
    data = events.map do |e|
      {
        name: e.name,
        address: e.address,
        category: e.category,
        datetime: e.datetime.to_s,
        description: e.description,
        participants: e.participants.map(&:email)
      }
    end
    File.write(FILE_NAME, JSON.pretty_generate(data))
  end

  def self.load(users)
    return [] unless File.exist?(FILE_NAME)
    data = JSON.parse(File.read(FILE_NAME), symbolize_names: true)
    data.map do |e|
      event = Event.new(e[:name], e[:address], e[:category], DateTime.parse(e[:datetime]), e[:description])
      event.participants = users.select { |u| e[:participants].include?(u.email) }
      event
    end
  end
end
