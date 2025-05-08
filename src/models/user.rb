class User
  attr_accessor :name, :email, :city

  def initialize(name, email, city)
    @name = name
    @email = email
    @city = city
  end
end
