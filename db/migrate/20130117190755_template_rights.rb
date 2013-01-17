class TemplateRights < ActiveRecord::Migration
  def change
    create_table :template_rights do |t|
      t.integer :template_id
      t.integer :user_id
      t.datetime :started_at
      t.datetime :expired_at
      t.integer :price

      t.timestamps
    end
  end
end
