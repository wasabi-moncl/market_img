class Position < ActiveRecord::Base
  attr_accessible :height, :name, :part, :template_id, :width, :x_pos, :y_pos
  belongs_to :template
  has_one :photo
  
  #for generate test seed
  def self.association_to_the_template
    template = Template.first
    self.all.each do |position|
      position.template = template
    end
    puts "assciate:" + template.positions.count.to_s + "items to template"
  end
end
