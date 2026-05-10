class CreateMilestones < ActiveRecord::Migration[8.1]
  def change
    create_table :milestones do |t|
      t.string :name, null: false
      t.string :description
      t.date :occurred_at
      t.string :slug, null: false
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
