class CreateMolds < ActiveRecord::Migration
  def change
    create_table :molds do |t|
      t.string :name
      t.integer :part
      t.integer :template_id
      t.integer :element_id

      t.timestamps
    end
  end
end
