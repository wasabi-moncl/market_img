class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username,         :null => false  # if you use another field as a username, for example email, you can safely remove this field.
      t.string :email,            :default => nil # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil
      t.string :brand
      t.string :branch
      t.string :name
      t.string :mobile
      t.string :emergency_call
      t.string :shop_tel
      t.string :manager_name
      t.integer :brand_id
      t.integer :brand_category_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end