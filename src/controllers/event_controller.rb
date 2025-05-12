class EventController
  def initialize(events, user_controller)
    @events = events
    @user_controller = user_controller
  end

  def create_event(name, address, category, datetime, description)
    return unless Event::CATEGORIES.include?(category)
    @events << Event.new(name, address, category, datetime, description)
  end

  def list_events
    @events.sort_by(&:datetime)
  end

  def confirm_participation(event_index)
    event = @events[event_index]
    event.participants << @user_controller.current_user unless event.participants.include?(@user_controller.current_user)
  end

  def cancel_participation(event_index)
    event = @events[event_index]
    event.participants.delete(@user_controller.current_user)
  end

  def my_events
    @events.select { |e| e.participants.include?(@user_controller.current_user) }
  end

  def happening_now
    @events.select(&:happening_now?)
  end

  def past_events
    @events.select(&:past_event?)
  end

  def save
    EventStorage.save(@events)
  end
end
