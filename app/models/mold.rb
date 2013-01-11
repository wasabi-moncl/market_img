class Mold < ActiveRecord::Base
  attr_accessible :name, :part, :template_id
  belongs_to :template
  belongs_to :element
end
