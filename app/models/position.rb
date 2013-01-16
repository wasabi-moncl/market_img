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
  
  def geometry
    if x_pos.nil? && y_pos.nil?
      result = "+0+0"
    elsif x_pos.nil? && y_pos.class == Fixnum
      result = "+0" + operation(y_pos)
    elsif x_pos.class == Fixnum && y_pos.nil?
      result = operation(x_pos) + "+0"
    else
      result = operation(x_pos) + operation(y_pos)
    end
    result
  end
end
private
def operation(number)
  if number > -1
    "+" + number.to_s
  else
    number.to_s
  end
end