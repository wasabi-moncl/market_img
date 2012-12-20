class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :last_login_at, :username, :password, :password_confirmation, :email
  attr_accessible :name, :mobile, :emergency_call, :shop_tel, :manager_name, :brand, :branch
  has_many :photos
  has_many :labels
  has_many :items
  
  validates_uniqueness_of :username
  validates_uniqueness_of :email    

  validates_presence_of :username
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
    
end
