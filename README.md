# City Event Notification System

A Ruby application for managing city events, allowing users to create, join, and track various events happening in their city.

## Overview

This application provides a command-line interface for users to:
- Register with their personal information
- Create new events in various categories
- Browse and join existing events
- Track events they're participating in
- View events happening now and past events

## System Requirements

- Ruby (version 2.5 or higher recommended)
- Required gems (see Gemfile)

## Installation

1. Clone the repository
2. Install dependencies:
   ```
   bundle install
   ```

## Usage

Run the application with:

```
ruby main.rb
```

### First-time Setup

When you first run the application, you'll be prompted to:
1. Enter your name
2. Enter your email
3. Enter your city

This information is used to create your user profile in the system.

### Main Menu Options

After registration, you'll see the following menu options:

1. **Create Event** - Create a new event with details like name, location, category, date/time, and description
2. **List Events** - View all events in the system, sorted by date
3. **Join Event** - Sign up to participate in an event
4. **Cancel Participation** - Remove yourself from an event you previously joined
5. **My Events** - View all events you're participating in
6. **Events Happening Now** - View events currently in progress
7. **Past Events** - View events that have already occurred
8. **Exit** - Save all data and exit the application

## Project Structure

```
/
├── spec/                     # Test files
│   ├── controllers/          # Controller tests
│   ├── models/               # Model tests
│   └── spec_helper.rb        # Test configuration
├── src/                      # Source code
│   ├── controllers/          # Application controllers
│   │   ├── event_controller.rb
│   │   └── user_controller.rb
│   ├── models/               # Data models
│   │   ├── event_storage.rb  # Persistence layer
│   │   ├── event.rb          # Event model
│   │   └── user.rb           # User model
│   └── views/                # View templates (currently empty)
├── events.data               # Persistent storage for events
├── Gemfile                   # Ruby dependencies
└── main.rb                   # Application entry point
```

## Models

### User

The `User` class represents a system user with the following attributes:
- `name`: User's full name
- `email`: User's email address (used as unique identifier)
- `city`: User's city of residence

### Event

The `Event` class represents an event with the following attributes:
- `name`: Event name
- `address`: Event location
- `category`: Event type (Party, Sport, Concert, or Conference)
- `datetime`: Date and time when the event occurs
- `description`: Detailed description of the event
- `participants`: List of users participating in the event

Events also have methods to determine if they are:
- `happening_now?`: Currently in progress (within a 2-hour window)
- `past_event?`: Already completed

## Controllers

### UserController

Manages user registration and tracking:
- `register(name, email, city)`: Creates a new user and sets as current user
- `all_users`: Returns all registered users
- `current_user`: Returns the currently active user

### EventController

Handles all event-related operations:
- `create_event`: Creates a new event
- `list_events`: Returns all events sorted by date
- `confirm_participation`: Adds current user to event participants
- `cancel_participation`: Removes current user from event participants
- `my_events`: Returns events the current user is participating in
- `happening_now`: Returns events currently in progress
- `past_events`: Returns events that have already occurred
- `save`: Persists events to storage

## Data Persistence

The `EventStorage` module handles saving and loading events:
- Events are stored in JSON format in the `events.data` file
- User participation is tracked by email address

## Running Tests

Run the test suite with:

```
bundle exec rspec
```

## Future Enhancements

Potential improvements for future versions:
- User authentication
- Event categories management
- Location-based event filtering
- Email notifications for upcoming events
- Web interface