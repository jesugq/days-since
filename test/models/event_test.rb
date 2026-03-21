require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "should be valid with all attributes" do
    event = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today,
      slug: "test-event"
    )
    assert event.valid?
  end

  test "should not be valid without a name" do
    event = Event.new(
      description: "Test Description",
      occurred_on: Date.today,
      slug: "test-event"
    )
    assert_not event.valid?
  end
  
  test "should not be valid without a description" do
    event = Event.new(
      name: "Test Event",
      occurred_on: Date.today,
      slug: "test-event"
    )
    assert_not event.valid?
  end
  
  test "should not be valid without a occurred_on" do
    event = Event.new(
      name: "Test Event",
      description: "Test Description",
      slug: "test-event"
    )
    assert_not event.valid?
  end
  
  test "should not be valid without a slug" do
    event = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today
    )
    assert_not event.valid?
  end
  
  test "should not be valid with a duplicate slug" do
    event_0 = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today,
      slug: "duplicate-event"
    )
    assert event_0.valid?
    assert event_0.save

    event_1 = Event.new(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today,
      slug: "duplicate-event"
    )
    assert_not event_1.valid?
    assert_not event_1.save
  end
end
