require 'date'
require_relative '../../src/models/event'
require_relative '../../src/models/user'

RSpec.describe Event do
  let(:event) { Event.new("Concert", "Central Park", "Concert", DateTime.now + 1, "Free concert in the park") }

  it "initializes correctly" do
    expect(event.name).to eq("Concert")
    expect(event.address).to eq("Central Park")
    expect(event.category).to eq("Concert")
    expect(event.description).to eq("Free concert in the park")
    expect(event.participants).to eq([])
  end

  it "detects an ongoing event" do
    now = DateTime.now
    happening = Event.new("Live", "Downtown", "Party", now, "Now live!")
    expect(happening.happening_now?).to be true
  end

  it "detects a past event" do
    old = Event.new("Old Event", "Old St", "Party", DateTime.now - 1, "Old")
    expect(old.past_event?).to be true
  end
end
