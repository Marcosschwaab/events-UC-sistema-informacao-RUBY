require 'date'
require_relative '../../src/models/event'
require_relative '../../src/models/user'
require_relative '../../src/controllers/user_controller'
require_relative '../../src/controllers/event_controller'

RSpec.describe EventController do
  let(:user_controller) do
    uc = UserController.new
    uc.register("John", "john@example.com", "NY")
    uc
  end

  let(:events) { [] }
  let(:controller) { EventController.new(events, user_controller) }

  it "creates an event" do
    controller.create_event("Game Night", "Local Club", "Party", DateTime.now + 1, "Board games")
    expect(events.length).to eq(1)
    expect(events.first.name).to eq("Game Night")
  end

  it "adds and removes participant" do
    controller.create_event("Yoga", "Studio", "Sport", DateTime.now + 2, "Stretch")
    controller.confirm_participation(0)
    expect(events.first.participants).to include(user_controller.current_user)

    controller.cancel_participation(0)
    expect(events.first.participants).not_to include(user_controller.current_user)
  end
end
