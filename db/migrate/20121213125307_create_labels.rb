class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.integer :user_id
      t.integer :template_id
      t.integer :x_pos
      t.integer :y_pos
      t.integer :width
      t.integer :height
      t.integer :kerning
      t.string :color
      t.string :font
      t.string :size
      t.string :column

      t.timestamps
    end
  end
end
