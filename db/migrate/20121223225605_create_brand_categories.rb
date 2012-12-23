class CreateBrandCategories < ActiveRecord::Migration
  def change
    create_table :brand_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
