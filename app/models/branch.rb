class Branch < ActiveRecord::Base
  attr_accessible :branch, :mall
  has_many :users
  
  def mall_branch
    self.mall + " " + self.branch
  end
end
