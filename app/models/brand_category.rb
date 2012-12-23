class BrandCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :brands
end
