require_relative '../../src/models/user'

RSpec.describe User do
  it "initializes correctly" do
    user = User.new("Alice", "alice@example.com", "New York")
    expect(user.name).to eq("Alice")
    expect(user.email).to eq("alice@example.com")
    expect(user.city).to eq("New York")
  end
end
