class RenameQualificationInCvTrans < ActiveRecord::Migration[5.0]
  def change
    rename_column :cv_trans, :qualification, :qualifications
  end
end
