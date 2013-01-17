class Element < ActiveRecord::Base
  attr_accessible :name, :part, :template_id, :url, :mold_id, :photo_id
  belongs_to :template
  belongs_to :mold
  belongs_to :photo
end
