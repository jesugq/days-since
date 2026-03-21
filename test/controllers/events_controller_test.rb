require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @event = Event.create(
      name: "Test Event",
      description: "Test Description",
      occurred_on: Date.today,
      slug: "test-event"
    )
  end
  
  test "should get index" do
    get events_path
    assert_response :success
    assert_select "li", "Test Event"
  end

  test "should get show" do
    get event_path(@event)
    assert_response :success
    assert_select "p", "Name: Test Event"
    assert_select "p", "Description: Test Description"
    assert_select "p", "Occurred On: #{Date.today}"
    assert_select "p", "Slug: test-event"
  end

  test "should get new" do
    get new_event_path
    assert_response :success
    assert_select "form"
  end

  test "should get edit" do
    get edit_event_path(@event)
    assert_response :success
    assert_select "form"
  end

  test "should create event" do
    assert_difference "Event.count" do
      post events_path, params: { event: {
        name: "Test Event",
        description: "Test Description",
        occurred_on: Date.today,
        slug: "test-event"
      } }
    end
    assert_response :redirect
    assert_redirected_to event_path(Event.last)
    assert_equal "Test Event", Event.last.name
    assert_equal "Test Description", Event.last.description
    assert_equal Date.today, Event.last.occurred_on
    assert_equal "test-event", Event.last.slug
  end
  
  test "should update event" do
    patch event_path(@event), params: { event: {
      name: "Updated Event",
      description: "Updated Description",
      occurred_on: Date.today,
      slug: "updated-event"
    } }
    assert_redirected_to event_path(@event)
    @event.reload
    assert_equal "Updated Event", @event.name
    assert_equal "Updated Description", @event.description
    assert_equal Date.today, @event.occurred_on
    assert_equal "updated-event", @event.slug
  end

  test "should destroy event" do
    assert_difference "Event.count", -1 do
      delete event_path(@event)
    end
    assert_redirected_to events_path
  end
end
