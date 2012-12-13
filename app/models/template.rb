class Template < ActiveRecord::Base
  attr_accessible :name
  has_many :positions
  has_many :photos
  has_many :labels
  
  has_and_belongs_to_many :items
  
  def label_columns
    except = [:id, :created_at, :updated_at, :url, :user_id, :template_id, :mall_code]
    result = Array.new
    i = 0
    unless self.items.empty?
      columns = self.items.first.attributes.keys.map(&:to_sym) - except
    end
    columns.each do |column|
      result << {:column => column, :part => i}
      i = i + 1
    end
    result
  end
end
