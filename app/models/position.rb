class Position < ActiveRecord::Base
  attr_accessible :height, :name, :part, :template_id, :width, :x_pos, :y_pos
  belongs_to :template
  belongs_to :mold
  has_one :photo
  
  #for generate test seed
  def self.association_to_the_template(current_user)
    template = Template.first
    self.all.each do |position|
      position.template = template
    end
    puts "associate " + template.positions.count.to_s + " items to template"
  end
end
