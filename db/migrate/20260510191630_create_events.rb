class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description
      t.date :occurred_at
      t.string :slug, null: false

      t.timestamps
    end
  end
end
