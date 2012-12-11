class Template < ActiveRecord::Base
  attr_accessible :name
  has_many :positions
  has_many :photos
  has_and_belongs_to_many :items
end
