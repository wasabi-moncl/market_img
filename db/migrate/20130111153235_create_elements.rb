class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.integer :part
      t.integer :template_id
      t.integer :mold_id
      t.string :url

      t.timestamps
    end
  end
end
