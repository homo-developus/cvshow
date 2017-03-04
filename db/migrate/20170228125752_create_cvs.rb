class CreateCvs < ActiveRecord::Migration[5.0]
  def change
    create_table :cvs do |t|
      t.string :token, limit: 6, index: true, unique: true
      t.datetime :birthday, null: false
      t.string :email, null: false
      t.string :phone
      t.string :skype, null: false

      t.timestamps
    end
  end
end
