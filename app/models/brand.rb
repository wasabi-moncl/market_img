class Brand < ActiveRecord::Base
  attr_accessible :category_id, :name
  belongs_to :brand_category
end
