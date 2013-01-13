class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :name
      t.integer :template_id
      t.integer :part
      t.integer :x_pos
      t.integer :y_pos
      t.integer :width
      t.integer :height
      t.integer :mold_id

      t.timestamps
    end
  end
end
