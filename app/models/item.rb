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
    self.templates.first.positions
  end
  
end
