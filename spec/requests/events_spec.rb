require "rails_helper"

RSpec.describe "Events", type: :request do
  let(:valid_attributes) { { name: "Test Event", description: "Test Description", occurred_on: Date.today } }
  let(:event) { Event.create!(valid_attributes) }

  describe "HTML format" do
    it "GET /events returns success" do
      get events_path
      expect(response).to have_http_status(:success)
    end

    it "GET /events/:slug returns success" do
      get event_path(event)
      expect(response).to have_http_status(:success)
    end

    it "GET /events/new returns success" do
      get new_event_path
      expect(response).to have_http_status(:success)
    end

    it "GET /events/:slug/edit returns success" do
      get edit_event_path(event)
      expect(response).to have_http_status(:success)
    end

    it "POST /events creates and redirects" do
      expect {
        post events_path, params: { event: { name: "New Event", description: "Desc", occurred_on: Date.today } }
      }.to change(Event, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it "POST /events auto-generates a slug" do
      post events_path, params: { event: { name: "My Cool Event", description: "Desc", occurred_on: Date.today } }
      expect(Event.last.slug).to eq("my-cool-event")
    end

    it "PATCH /events/:slug updates and redirects" do
      patch event_path(event), params: { event: { name: "Updated Event" } }
      expect(response).to have_http_status(:redirect)
      expect(event.reload.name).to eq("Updated Event")
    end

    it "DELETE /events/:slug destroys and redirects" do
      event
      expect {
        delete event_path(event)
      }.to change(Event, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end

    it "returns 404 for a nonexistent slug" do
      get "/events/nonexistent-slug"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "JSON format" do
    it "GET /events.json returns events with days_since" do
      event
      get events_path(format: :json)
      expect(response).to have_http_status(:success)
      expect(response.content_type).to match(%r{application/json})
      body = JSON.parse(response.body)
      expect(body["events"]).to be_an(Array)
      expect(body["events"].first["name"]).to eq("Test Event")
      expect(body["events"].first).to have_key("days_since")
    end

    it "GET /events.json returns pagination metadata" do
      event
      get events_path(format: :json, page: 1, per_page: 10)
      body = JSON.parse(response.body)
      expect(body["meta"]["page"]).to eq(1)
      expect(body["meta"]["per_page"]).to eq(10)
      expect(body["meta"]["total_count"]).to eq(1)
      expect(body["meta"]["total_pages"]).to eq(1)
    end

    it "GET /events/:slug.json returns event with days_since" do
      get event_path(event, format: :json)
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)
      expect(body["name"]).to eq("Test Event")
      expect(body["slug"]).to eq("test-event")
      expect(body).to have_key("days_since")
    end

    it "POST /events.json creates and returns event with slug" do
      expect {
        post events_path(format: :json), params: { event: { name: "JSON Event", description: "Via API", occurred_on: Date.today } }
      }.to change(Event, :count).by(1)
      expect(response).to have_http_status(:created)
      body = JSON.parse(response.body)
      expect(body["name"]).to eq("JSON Event")
      expect(body["slug"]).to eq("json-event")
    end

    it "POST /events.json with invalid data returns errors" do
      post events_path(format: :json), params: { event: { name: "" } }
      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body).to have_key("errors")
    end

    it "PATCH /events/:slug.json updates and returns event" do
      patch event_path(event, format: :json), params: { event: { name: "Updated via JSON" } }
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)
      expect(body["name"]).to eq("Updated via JSON")
    end

    it "DELETE /events/:slug.json destroys and returns no content" do
      event
      expect {
        delete event_path(event, format: :json)
      }.to change(Event, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 JSON for a nonexistent slug" do
      get "/events/nonexistent-slug.json"
      expect(response).to have_http_status(:not_found)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("Not found")
    end
  end
end
