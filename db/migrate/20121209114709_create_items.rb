class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :template_id
      t.integer :brand_id
      t.string :name
      t.string :item_code
      t.string :mall_code
      t.string :url
      t.integer :price
      t.integer :discount_rate
      t.integer :discount_price
      t.string :fabric
      t.string :laundry
      t.text :description
      t.string :color
      t.string :size
      t.integer :user_id

      t.timestamps
    end
  end
end
