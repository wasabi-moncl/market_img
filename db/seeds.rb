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
      email: 'admin@moncl.net',
      brand_id: 1,
      username: "admin",
      password: "1111"
    },
    { 
      email: 'wasabi@moncl.net',
      brand_id: 1,
      username: "onesup",
      password: "1111"
     },
     { 
       email: 'test@moncl.net',
       brand_id: 1,
       username: "test",
       password: "1111"
      },
      { 
        email: 'moncl@moncl.net',
        brand_id: 1,
        username: "moncl",
        password: "1111"
      }
      
  ]
)
puts'"onesup", "test" 계정 생성완료'
template = Template.create(
  [
    {
      name: "시슬리(영패션)"
    },
    {
      name: "게스"
    }
  ]
)

  template_id = Template.last.id
Position.create(
  [
    {
      name: "sisley_0",
      part: 0,
      template_id: template_id,
      x_pos: 1,
      y_pos: 1
    },
    {
      name: "sisley_1",
      part: 1,
      template_id: template_id,
      x_pos: 32,
      y_pos: 1077
    },
    {
      name: "sisley_2",
      part: 2,
      template_id: template_id,
      x_pos: 75,
      y_pos: 1646
    },
    {
      name: "sisley_3",
      part: 3,
      template_id: template_id,
      x_pos: 232,
      y_pos: 1646
    },
    {
      name: "sisley_4",
      part: 4,
      template_id: template_id,
      x_pos: 390,
      y_pos: 1646
    },
    {
      name: "sisley_5",
      part: 5,
      template_id: template_id,
      x_pos: 550,
      y_pos: 1646
    },
    {
      name: "guess_0",
      part: 0,
      template_id: 2,
      x_pos: 1,
      y_pos: 1
    },
    {
      name: "guess_1",
      part: 1,
      template_id: 2,
      x_pos: 115,
      y_pos: 1317
    },
    {
      name: "guess_2",
      part: 2,
      template_id: 2,
      x_pos: 115,
      y_pos: 2544
    },
    {
      name: "guess_3",
      part: 3,
      template_id: 2,
      x_pos: 115,
      y_pos: 3107
    },
    {
      name: "guess_4",
      part: 4,
      template_id: 2,
      x_pos: 115,
      y_pos: 3670
    },
    {
      name: "guess_5",
      part: 5,
      template_id: 2,
      x_pos: 115,
      y_pos: 4233
    },
    {
      name: "guess_6",
      part: 6,
      template_id: 2,
      x_pos: 115,
      y_pos: 4796
    },
    {
      name: "guess_7",
      part: 7,
      template_id: 2,
      x_pos: 115,
      y_pos: 5359
    }
  ]
)

puts Template.first.name + ' 템플릿 생성완료'

# Label.create(
#   [
#     {
#       part: 0,
#       template_id: template_id,
#       x_pos: 1,
#       y_pos: 1,
#       gravity: "North",
#       color: "#ffcfdf"
#       size: "26"
#     },
#   ]
# )

Position.association_to_the_template(User.find(3))


# photos = ['MC1G2D401DB.png',   'MC1G2D403GE_1.png',  'MCD02D409BL.png',    'MCD02D503GE_1.png',
# 'MC1G2D401DB_1.png',  'MC1G2D403MT.png',    'MCD02D409BL_1.png',  'MCD02D503KK.png',
# 'MC1G2D402GE.png',    'MC1G2D403MT_1.png',  'MCD02D409IV.png',    'MCD02D503KK_1.png',
# 'MC1G2D402GE_1.png',  'MCD01D908NV.png',    'MCD02D409IV_1.png',  'MCH02C301DI.png',
# 'MC1G2D403GE.png',    'MCD01D908NV_1.png',  'MCD02D503GE.png',    'MCH02C301DI_1.png' ]
photos = ['bg_sisley.png']

photos.each do |x|
  Photo.create(:photo_file => open(Rails.root.to_s + "/db/photos/" + x), :template_id => 1, :part => 0)
end

  
  

