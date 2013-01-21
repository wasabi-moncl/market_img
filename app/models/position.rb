include MiniGeo
class Position < ActiveRecord::Base
  attr_accessible :height, :name, :part, :template_id, :width, :x_pos, :y_pos, :mold_id
  attr_accessible :labels_attributes

  belongs_to :template
  belongs_to :mold
  has_many :labels
  has_one :photo

  accepts_nested_attributes_for :labels, :allow_destroy => true
  #for generate test seed
  def self.association_to_the_template(current_user)
    template = Template.first
    self.all.each do |position|
      position.template = template
    end
    puts "associate " + template.positions.count.to_s + " items to template"
  end
  
end
