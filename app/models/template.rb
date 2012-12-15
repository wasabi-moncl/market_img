#encoding: utf-8
class Template < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :labels_attributes

  has_many :positions
  has_many :photos
  has_many :labels
  has_and_belongs_to_many :items

  #label에 컬러코드가 없으면 저장 안됨.
  accepts_nested_attributes_for :labels, :reject_if => lambda { |a| a[:color].blank? } 


  def label_columns
    result = Array.new
    except = [:id, :created_at, :updated_at, :url, :user_id, :template_id, :mall_code]
    unless self.items.empty?
      columns = self.items.first.attributes.keys.map(&:to_sym) - except
    end
    columns.each do |column|
      result << column
    end
    result
  end
end
