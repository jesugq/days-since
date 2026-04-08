json.extract! @event, :id, :name, :description, :occurred_on, :slug, :created_at, :updated_at
json.days_since @event.days_since
