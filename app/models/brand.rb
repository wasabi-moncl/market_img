class Brand < ActiveRecord::Base
  attr_accessible :brand_category_id, :name
  belongs_to :brand_category
  has_many :users
  has_many :templates
end
