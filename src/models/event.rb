require 'date'

class Event
  CATEGORIES = ['Party', 'Sport', 'Concert', 'Conference']

  attr_accessor :name, :address, :category, :datetime, :description, :participants

  def initialize(name, address, category, datetime, description)
    @name = name
    @address = address
    @category = category
    @datetime = datetime
    @description = description
    @participants = []
  end

  def happening_now?
    now = DateTime.now
    (@datetime..@datetime + (2.0/24)) === now
  end

  def past_event?
    DateTime.now > @datetime + (2.0/24)
  end
end
