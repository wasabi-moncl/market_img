class TemplateRight < ActiveRecord::Base
  attr_accessible :user_id, :template_id, :started_at, :expired_at, :price
  belongs_to :user
  belongs_to :template
end
