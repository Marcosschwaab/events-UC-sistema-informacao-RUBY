class UserController
  attr_reader :current_user

  def initialize
    @users = []
  end

  def register(name, email, city)
    user = User.new(name, email, city)
    @users << user
    @current_user = user
  end

  def all_users
    @users
  end
end
