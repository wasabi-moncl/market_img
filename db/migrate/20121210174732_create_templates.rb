class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.integer :brand_id
      t.text :code
      t.timestamps
    end
  end
end
