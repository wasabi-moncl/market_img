class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.integer :photo_id
      t.integer :pos_x
      t.integer :pos_y
      t.string :font_color
      t.string :bg_color
      t.integer :font_size
      t.text :content

      t.timestamps
    end
  end
end
