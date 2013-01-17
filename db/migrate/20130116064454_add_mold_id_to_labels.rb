class AddMoldIdToLabels < ActiveRecord::Migration
  def change
    add_column :labels, :mold_id, :integer
    add_column :labels, :position_id, :integer
  end
end
