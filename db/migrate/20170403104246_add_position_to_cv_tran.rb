class AddPositionToCvTran < ActiveRecord::Migration[5.0]
  def change
    add_column :cv_trans, :position, :string
  end
end
