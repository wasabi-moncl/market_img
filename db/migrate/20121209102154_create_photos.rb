class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_file
      t.integer :item_id
      t.integer :user_id
      t.integer :template_id
      t.string :item_code
      t.integer :part
      t.boolean :has_code, :default => false
      t.timestamps
    end
  end
end
