class Element < ActiveRecord::Base
  attr_accessible :name, :part, :template_id
  belongs_to :template
  has_many :molds
end
