class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name
      t.integer :brand_category_id

      t.timestamps
    end
  end
end
