require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:valid_attributes) { { name: "Test Event", description: "Test Description", occurred_on: Date.today, slug: "test-event" } }
  let(:event) { Event.create!(valid_attributes) }

  describe "HTML format" do
    it "GET /events returns success" do
      get events_path
      expect(response).to have_http_status(:success)
    end

    it "GET /events/:id returns success" do
      get event_path(event)
      expect(response).to have_http_status(:success)
    end

    it "GET /events/new returns success" do
      get new_event_path
      expect(response).to have_http_status(:success)
    end

    it "GET /events/:id/edit returns success" do
      get edit_event_path(event)
      expect(response).to have_http_status(:success)
    end

    it "POST /events creates and redirects" do
      expect {
        post events_path, params: { event: { name: "New Event", description: "Desc", occurred_on: Date.today, slug: "new-event" } }
      }.to change(Event, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it "PATCH /events/:id updates and redirects" do
      patch event_path(event), params: { event: { name: "Updated Event" } }
      expect(response).to have_http_status(:redirect)
      expect(event.reload.name).to eq("Updated Event")
    end

    it "DELETE /events/:id destroys and redirects" do
      event
      expect {
        delete event_path(event)
      }.to change(Event, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "JSON format" do
    it "GET /events.json returns events as JSON" do
      event
      get events_path(format: :json)
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(%r{application/json})
      body = JSON.parse(response.body)
      expect(body).to be_an(Array)
      expect(body.first["name"]).to eq("Test Event")
    end

    it "GET /events/:id.json returns event as JSON" do
      get event_path(event, format: :json)
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)
      expect(body["name"]).to eq("Test Event")
      expect(body["slug"]).to eq("test-event")
    end

    it "POST /events.json creates and returns event" do
      expect {
        post events_path(format: :json), params: { event: { name: "JSON Event", description: "Via API", occurred_on: Date.today, slug: "json-event" } }
      }.to change(Event, :count).by(1)
      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body["name"]).to eq("JSON Event")
    end

    it "POST /events.json with invalid data returns errors" do
      post events_path(format: :json), params: { event: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "PATCH /events/:id.json updates and returns event" do
      patch event_path(event, format: :json), params: { event: { name: "Updated via JSON" } }
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)
      expect(body["name"]).to eq("Updated via JSON")
    end

    it "DELETE /events/:id.json destroys and returns no content" do
      event
      expect {
        delete event_path(event, format: :json)
      }.to change(Event, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
