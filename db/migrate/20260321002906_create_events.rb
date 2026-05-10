class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.date :occurred_on
      t.string :slug

      t.timestamps
    end
  end
end
