class BrandCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :brands
  accepts_nested_attributes_for :brands, :reject_if => :all_blank, :allow_destroy => true
  has_many :users
end