json.events @events do |event|
  json.extract! event, :id, :name, :description, :occurred_on, :slug, :created_at, :updated_at
  json.days_since event.days_since
end

json.meta do
  json.page @page
  json.per_page @per_page
  json.total_count @total_count
  json.total_pages (@total_count.to_f / @per_page).ceil
end
