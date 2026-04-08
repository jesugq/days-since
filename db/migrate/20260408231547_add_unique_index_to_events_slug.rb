class AddUniqueIndexToEventsSlug < ActiveRecord::Migration[8.1]
  def change
    add_index :events, :slug, unique: true
  end
end
