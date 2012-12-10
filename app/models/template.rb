class Template < ActiveRecord::Base
  attr_accessible :name
  has_many :positions
  
end
