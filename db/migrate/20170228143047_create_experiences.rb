class CreateExperiences < ActiveRecord::Migration[5.0]
  def change
    create_table :experiences do |t|
      t.belongs_to :cv_tran
      t.datetime :started_at, null: false
      t.datetime :finished_at
      t.string :position, null: false
      t.string :company, null: false
      t.string :company_site
      t.string :company_address
      t.string :duties, array: true

      t.timestamps
    end
  end
end
