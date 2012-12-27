# coding : utf-8
require 'csv'

CSV.foreach(Rails.root.join("db", "category_brand_list.csv"), headers: true) do |row|
  if BrandCategory.find_by_name(row[0]).nil?
    BrandCategory.create! do |category|
      category.name = row[0]
    end
  end
end
puts "Imported " + BrandCategory.count.to_s + " categories"
CSV.foreach(Rails.root.join("db", "category_brand_list.csv"), headers: true) do |row|
  if BrandCategory.find_by_name(row[0]).brands.find_by_name(row[1]).nil? 
    unless row[1].nil?
      Brand.create! do |brand|
        brand.name = row[1]
        brand.brand_category = BrandCategory.find_by_name(row[0])
      end
    end
  end
end
puts "Imported " + Brand.count.to_s + " brands"
CSV.foreach(Rails.root.join("db", "branch_list.csv"), headers: true) do |row|
  Branch.create! do |branch|
    branch.mall = row[0]
    branch.branch = row[1]
  end
end
puts "Imported " + Branch.count.to_s + " branchs"
users = User.create(
  [
    { 
      email: 'wasabi@moncl.net',
      username: "onesup",
      password: "1111"
     },
     { 
       email: 'test@moncl.net',
       username: "test",
       password: "1111"
      }     
  ]
)
puts'"onesup", "test" 계정 생성완료'
template = Template.create(
  [
    {
      name: "시슬리(영패션)"
    }
  ]
)
5.times do |i|
  name = "sisley_" + i.to_s
  template_id = Template.last.id
  p = Position.create(
  [
    {
      name: name,
      part: i,
      template_id: template_id,
    }
  ]
)
end
puts Template.first.name + ' 템플릿 생성완료'
Position.association_to_the_template


# photos = ['MC1G2D401DB.png',   'MC1G2D403GE_1.png',  'MCD02D409BL.png',    'MCD02D503GE_1.png',
# 'MC1G2D401DB_1.png',  'MC1G2D403MT.png',    'MCD02D409BL_1.png',  'MCD02D503KK.png',
# 'MC1G2D402GE.png',    'MC1G2D403MT_1.png',  'MCD02D409IV.png',    'MCD02D503KK_1.png',
# 'MC1G2D402GE_1.png',  'MCD01D908NV.png',    'MCD02D409IV_1.png',  'MCH02C301DI.png',
# 'MC1G2D403GE.png',    'MCD01D908NV_1.png',  'MCD02D503GE.png',    'MCH02C301DI_1.png' ]
photos = ['bg_sisley.png']

photos.each do |x|
  Photo.create(:photo_file => open(Rails.root.to_s + "/db/photos/" + x), :template_id => 1, :part => 0)
end

  
  

