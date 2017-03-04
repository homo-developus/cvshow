class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.belongs_to :experience
      t.string :name, null: false
      t.string :description, limit: 500
      t.string :link
      t.string :technologies

      t.timestamps
    end
  end
end
