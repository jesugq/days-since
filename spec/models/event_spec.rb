require "rails_helper"

RSpec.describe Event do
  describe "validations" do
    it "is valid with valid attributes" do
      event = Event.new(name: "Test Event", description: "Test Description", occurred_on: Date.today)
      expect(event).to be_valid
    end

    it "is not valid without a name" do
      event = Event.new(description: "Test Description", occurred_on: Date.today)
      expect(event).to be_invalid
    end

    it "is not valid without a description" do
      event = Event.new(name: "Test Event", occurred_on: Date.today)
      expect(event).to be_invalid
    end

    it "is not valid without an occurred_on" do
      event = Event.new(name: "Test Event", description: "Test Description")
      expect(event).to be_invalid
    end

    it "enforces slug uniqueness" do
      Event.create!(name: "First", description: "Desc", occurred_on: Date.today, slug: "duplicate")
      event = Event.new(name: "Second", description: "Desc", occurred_on: Date.today, slug: "duplicate")
      expect(event).to be_invalid
      expect(event.errors.full_messages).to include("Slug has already been taken")
    end
  end

  describe "#generate_slug" do
    it "auto-generates slug from name when slug is blank" do
      event = Event.new(name: "Quit Smoking", description: "Desc", occurred_on: Date.today)
      event.valid?
      expect(event.slug).to eq("quit-smoking")
    end

    it "does not overwrite a manually provided slug" do
      event = Event.new(name: "Quit Smoking", description: "Desc", occurred_on: Date.today, slug: "custom-slug")
      event.valid?
      expect(event.slug).to eq("custom-slug")
    end

    it "appends a number to avoid duplicate slugs" do
      Event.create!(name: "My Event", description: "Desc", occurred_on: Date.today)
      event = Event.new(name: "My Event", description: "Desc", occurred_on: Date.today)
      event.valid?
      expect(event.slug).to eq("my-event-2")
    end

    it "handles special characters in name" do
      event = Event.new(name: "Café & Résumé!", description: "Desc", occurred_on: Date.today)
      event.valid?
      expect(event.slug).to eq("cafe-resume")
    end
  end

  describe "#days_since" do
    it "returns the number of days since occurred_on" do
      event = Event.new(occurred_on: 10.days.ago.to_date)
      expect(event.days_since).to eq(10)
    end

    it "returns 0 for today" do
      event = Event.new(occurred_on: Date.current)
      expect(event.days_since).to eq(0)
    end

    it "returns nil when occurred_on is nil" do
      event = Event.new(occurred_on: nil)
      expect(event.days_since).to be_nil
    end

    it "returns a negative number for future dates" do
      event = Event.new(occurred_on: 5.days.from_now.to_date)
      expect(event.days_since).to eq(-5)
    end
  end

  describe "#to_param" do
    it "returns the slug" do
      event = Event.new(slug: "my-event")
      expect(event.to_param).to eq("my-event")
    end
  end
end
