class CreateCvTrans < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      CREATE TYPE lang AS ENUM ('en', 'ru', 'ua');
    SQL

    create_table :cv_trans do |t|
      t.belongs_to :cv

      t.column :tran_lang, :lang, null: false
      t.string :full_name, null: false
      t.string :marital_status
      t.string :address
      t.string :summary, limit: 500
      t.string :personal_skills
      t.json   :technical_skills
      t.string :qualification, limit: 100, array: true
      t.json :links
      t.json :languages

      t.timestamps
    end
  end

  def down
    drop_table :cv_trans

    execute <<-SQL
      DROP TYPE lang;
    SQL
  end
end
