# encoding: utf-8
class Item < ActiveRecord::Base
  attr_accessible :description, :discount_price, :discount_rate, :fabric, :item_code, :laundry, :mall_code, :name, :price, :url, :part
  has_many :photos
  has_and_belongs_to_many :templates
  
  belongs_to :template
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      item = find_by_id(row["id"]) || new
      item.attributes = row.to_hash.slice(*accessible_attributes)
      item.save!
    end
  end
  
  def parts
    positions = Array.new 
    self.templates.first.positions.each do |position|
      positions << position
    end
    parts = Array.new
    positions.each do |position|
      photo = Photo.where("part = ? AND item_code = ?", position.part, self.item_code)
      unless photo.first.nil?
        parts << {:position => position, :photo => photo.first}
      end
    end
    parts
  end
    
  #for generate test seed  
  def self.association_to_all_photos
    self.all.each do |item|
      photos = Photo.where(:item_code => item.item_code)
      item.photos << photos
    end
  end

  #for generate test seed  
  def self.association_to_the_template
    template = Template.first
    self.all.each do |item|
      item.templates << template
    end
    puts "assciate:" + template.items.count.to_s + "items to template"
  end
  
end
