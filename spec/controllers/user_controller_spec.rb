require_relative '../../src/controllers/user_controller'

RSpec.describe UserController do
  it "registers a user and sets current_user" do
    controller = UserController.new
    controller.register("John", "john@example.com", "LA")
    expect(controller.current_user.name).to eq("John")
    expect(controller.all_users.length).to eq(1)
  end
end
