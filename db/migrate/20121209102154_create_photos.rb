class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_file
      t.integer :item_id
      t.integer :user_id
      t.timestamps
    end
  end
end
