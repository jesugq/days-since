require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:event) { Event.create(name: "Test Event", description: "Test Description", occurred_on: Date.today, slug: "test-event") }

  it "should get index" do
    get events_path
    expect(response).to have_http_status(:success)
  end

  it "should get show" do
    get event_path(event)
    expect(response).to have_http_status(:success)
  end

  it "should get new" do
    get new_event_path
    expect(response).to have_http_status(:success)
  end

  it "should get edit" do
    get edit_event_path(event)
    expect(response).to have_http_status(:success)
  end

  it "should create event with a slug" do
    post events_path, params: { event: { name: "Test Event", description: "Test Description", occurred_on: Date.today, slug: "test-event" } }
    expect(response).to have_http_status(:redirect)
  end

  it "should create event without a slug" do
    post events_path, params: { event: { name: "Test Event", description: "Test Description", occurred_on: Date.today } }
    expect(response).to have_http_status(:redirect)
  end

  it "should update event with a slug" do
    patch event_path(event), params: { event: { name: "Updated Event", description: "Updated Description", occurred_on: Date.today, slug: "updated-event" } }
    expect(response).to have_http_status(:redirect)
  end

  it "should update event without a slug" do
    patch event_path(event), params: { event: { name: "Updated Event", description: "Updated Description", occurred_on: Date.today } }
    expect(response).to have_http_status(:redirect)
  end

  it "should destroy event" do
    delete event_path(event)
    expect(response).to have_http_status(:redirect)
  end
end