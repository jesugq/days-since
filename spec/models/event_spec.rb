require "rails_helper"

RSpec.describe Event do
  it "is valid with valid attributes" do
    event = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today,
      slug: "test-event"
    )
    expect(event).to be_valid
  end

  it "is not valid without a name" do
    event = Event.new(
      description: "Test Description",
      occurred_on: Date.today,
      slug: "test-event"
    )
    expect(event).to be_invalid
  end
  
  it "is not valid without a description" do
    event = Event.new(
      name: "Test Event",
      occurred_on: Date.today,
      slug: "test-event"
    )
    expect(event).to be_invalid
  end
  
  it "is not valid without a occurred_on" do
    event = Event.new(
      name: "Test Event",
      description: "Test Description",
      slug: "test-event"
    )
    expect(event).to be_invalid
  end
  
  it "is not valid without a slug" do
    event = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today
    )
    expect(event).to be_invalid
  end
  
  it "is not valid with a duplicate slug" do
    event_0 = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today,
      slug: "duplicate-event"
    )
    expect(event_0).to be_valid
    expect(event_0.save).to be_truthy

    event_1 = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today,
      slug: "duplicate-event"
    )
    expect(event_1).to be_invalid
    expect(event_1.errors.full_messages).to include("Slug has already been taken")
  end
end