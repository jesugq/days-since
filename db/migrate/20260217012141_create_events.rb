class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :all_day
      t.string :location
      t.string :slug

      t.timestamps
    end
  end
end
