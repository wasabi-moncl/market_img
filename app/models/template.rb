# require "erb"
#encoding: utf-8
class Template < ActiveRecord::Base
  attr_accessible :name, :brand_id
  attr_accessible :labels_attributes, :molds_attributes, :elements_attributes, :sent_controller

  belongs_to :brand
  
  has_many :positions
  has_many :photos
  has_many :labels
  has_many :molds
  has_many :elements
  has_and_belongs_to_many :items

  #label에 컬러코드가 없으면 저장 안됨.
  accepts_nested_attributes_for :labels, :reject_if => lambda { |a| a[:color].blank? } 
  accepts_nested_attributes_for :molds, :allow_destroy => true
  accepts_nested_attributes_for :elements, :allow_destroy => true
  
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
