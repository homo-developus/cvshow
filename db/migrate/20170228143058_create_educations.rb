class CreateEducations < ActiveRecord::Migration[5.0]
  def change
    create_table :educations do |t|
      t.belongs_to :cv_tran
      t.string :degree, null: false
      t.string :specialty
      t.string :institution, null: false
      t.integer :year, null: false
      t.string :institution_address

      t.timestamps
    end
  end
end
