class Template < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :labels_attributes
  has_many :positions
  has_many :photos
  has_many :labels
  
  has_and_belongs_to_many :items
  
  accepts_nested_attributes_for :labels, :reject_if => lambda { |a| a[:color].blank? }
  def label_columns
    except = [:id, :created_at, :updated_at, :url, :user_id, :template_id, :mall_code]
    result = Array.new
    i = 0
    unless self.items.empty?
      columns = self.items.first.attributes.keys.map(&:to_sym) - except
    end
    columns.each do |column|
      result << {:column => column}
      i = i + 1
    end
    result
  end
end
