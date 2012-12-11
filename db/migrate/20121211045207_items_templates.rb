class ItemsTemplates < ActiveRecord::Migration
  def change
    create_table :items_templates do |t|
      t.integer :item_id
      t.integer :template_id
    end
  end
end
