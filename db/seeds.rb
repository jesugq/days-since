# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Event.create!(name: "Event 1", description: "Description 1", occurred_at: Date.today + 1.day, slug: "event-1")
Event.create!(name: "Event 2", description: "Description 2", occurred_at: Date.today + 2.days, slug: "event-2")
Event.create!(name: "Event 3", description: "Description 3", occurred_at: Date.today + 3.days, slug: "event-3")

Milestone.create!(name: "Milestone 1", description: "Description 1", occurred_at: Date.today + 1.day, event_id: 1, slug: "milestone-1")
Milestone.create!(name: "Milestone 2", description: "Description 2", occurred_at: Date.today + 2.days, event_id: 2, slug: "milestone-2")
Milestone.create!(name: "Milestone 3", description: "Description 3", occurred_at: Date.today + 3.days, event_id: 3, slug: "milestone-3")
