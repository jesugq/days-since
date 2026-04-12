require "rails_helper"

RSpec.describe Event do
  context "validations" do
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
    
    it "is valid without a slug and generates a slug" do
      event = Event.new(
        name: "Test Event",
        description: "Test Description",
        occurred_on: Date.today
      )
      expect(event).to be_valid
      expect(event.save).to be_truthy
      expect(event.slug).to eq("test-event")
    end

    it "is valid without a slug and generates a unique slug" do
      event_0 = Event.new(
        name: "Test Event",
        description: "Test Description",
        occurred_on: Date.today,
      )
      expect(event_0).to be_valid
      expect(event_0.save).to be_truthy
      expect(event_0.slug).to eq("test-event")

      event_1 = Event.new(
        name: "Test Event",
        description: "Test Description",
        occurred_on: Date.today,
      )
      expect(event_1).to be_valid
      expect(event_1.save).to be_truthy
      expect(event_1.slug).to eq("test-event-1")
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

  describe "#days_since_occurred_on" do
    it "returns the number of days since the event occurred" do
      event = Event.new(
        name: "Test Event",
        description: "Test Description",
        occurred_on: Date.current - 1.day,
      )
      expect(event).to be_valid
      expect(event.save).to be_truthy
      expect(event.days_since_occurred_on).to eq(1)
    end

    it "returns nil if the event occurred in the future" do
      event = Event.new(
        name: "Test Event",
        description: "Test Description",
        occurred_on: Date.current + 1.day,
      )
      expect(event).to be_valid
      expect(event.save).to be_truthy
      expect(event.days_since_occurred_on).to be_nil
    end

    it "returns nil if the event does not have an occurred_on date" do
      event = Event.new(
        name: "Test Event",
        description: "Test Description",
      )
      expect(event.days_since_occurred_on).to be_nil
      expect(event.days_since_occurred_on).to be_nil
    end
  end
end
