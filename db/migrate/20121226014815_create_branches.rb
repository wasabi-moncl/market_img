class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :mall
      t.string :branch

      t.timestamps
    end
  end
end
