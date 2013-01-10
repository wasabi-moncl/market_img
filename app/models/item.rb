#encoding: utf-8
require 'roo'
class Item < ActiveRecord::Base
  attr_accessible :description, :discount_price, :discount_rate, :fabric, :item_code, :laundry, :mall_code, :name, :price, :url, :part, :size, :color
  has_many :photos
  has_and_belongs_to_many :templates
  belongs_to :template
  
  belongs_to :user
  
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Csv.new(file.path, nil, :ignore)
      when ".xls" then Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
  
  def self.import(file, user)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      item = find_by_id(row["id"]) || new
      item.attributes = row.to_hash.slice(*accessible_attributes)
      item.user = user
      item.save!
    end
  end
  
  def parts
    positions = Array.new 
    self.user.brand.templates.first.positions.each do |position|
      positions << position
    end
    parts = Array.new
    positions.each do |position|
      photo = Photo.where("part = ? AND item_code = ?", position.part, self.item_code)
      unless photo.first.nil?
        parts << {:position => position, :photo => photo.first}
      end
      photo = Photo.where("part = ? AND template_id = ?", position.part, self.templates.first.id)
      unless photo.first.nil?
        parts << {:position => position, :photo => photo.first}
      end
    end
    parts
  end
  
  def image_height
    template = self.templates.first
    height_values = Array.new
    photos = Array.new
    template.photos.each do |photo|
      height = Magick::Image.read(photo.photo_file.path).first.rows
      y_pos = template.positions.find_by_part(photo.part).y_pos
      height_values << y_pos + height
    end
    template.positions.each do |position|
      photo = self.photos.find_by_part(position.part)
      unless photo.nil?
        y_pos = position.y_pos
        height = Magick::Image.read(photo.photo_file.path).first.rows
        height_values << y_pos + height
      end
    end
    height_values.sort.last
  end
  
  def description
    words = Array.new
    str = self[:description]
    comma_separated_words = str.split(",")
    last_word = str.split(",")[-1]
    comma_separated_words = comma_separated_words[0..-2].map{|give_back_comma| give_back_comma + ","}
    comma_separated_words = comma_separated_words << last_word
    comma_separated_words.each{|x| words << x.split(" ")}
    words.flatten!
    i = 1
    enterd_str = String.new
    words.each do |word|
      unless i % 7 == 0
        enterd_str = enterd_str + word + " "
      else
        enterd_str = enterd_str + word + "\n"
      end
      i = i + 1
    end
    enterd_str
  end
    
  #for generate test seed  
  def self.association_to_all_photos
    self.all.each do |item|
      photos = Photo.where(:item_code => item.item_code)
      item.photos << photos
    end
  end

  #for generate test seed  
  def self.association_to_the_template(current_user)
    template = current_user.brand.templates.last
    self.all.each do |item|
      item.templates << template
    end
    puts "assciate:" + template.items.count.to_s + "items to template"
  end
  
end
