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
template = Template.create(
  [
    {
      name: "시슬리(영패션)"
    },
    {
      name: "게스",
      brand_id: 1
    }
  ]
)
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
User.first.templates << Template.last
puts'"onesup", "test" 계정 생성완료'

Mold.create(
  [
    {
      :name => "상품설명",
      :part => "1000",
      :template_id => Template.last.id
    }
  ]
)
template_id = Template.last.id
mold_id = Mold.find(1).id
Position.create(
  [
    {
      name: "상품설명bg",
      part: 100,
      template_id: template_id,
      mold_id: mold_id,
      x_pos: 0,
      y_pos: 0
    },
    {
      name: "상품설명0",
      part: 0,
      template_id: template_id,
      mold_id: mold_id,
      x_pos: 115,
      y_pos: 1315
    }
  ]
)
Element.create(
{
    name: "상품설명",
    template_id: Template.find(2).id,
    mold_id: Mold.first.id,
    part: 1,
} 
)

6.times do |i|
  one = i+1
  two = i+2
  Mold.create(
    {
      :name => "상품 나열" + one.to_s,
      :part => "100" + two.to_s,
      :template_id => Template.last.id
    }
  )
  Position.create(
    [
      {
        name: "상품 나열 bg",
        part: 100,
        template_id: Template.last.id,
        mold_id: two,
        x_pos: 0,
        y_pos: 0
      },
      {
        name: "상품 나열" + one.to_s,
        part: one,
        template_id: Template.last.id,
        mold_id: i + 2,
        x_pos: 115,
        y_pos: 11
      }
    ]
  )
  Photo.create(:photo_file => open(Rails.root.to_s + "/db/photos/" + 'bg-part2-3.png'), 
  :template_id => Template.last.id, :mold_id => two, :part => 100)
  Element.create(
    {
        name: "상품나열"+one.to_s,
        template_id: Template.find(2).id,
        mold_id: two,
        part: two
    } 
  )
  
end



puts "포지션 " + Position.count.to_s + "개 생성"

p_id = Position.where(:name => "상품설명bg").first.id
x_pos = 270
size = 17
color = "#ffffff"
gravity = "NorthWest"
font = "NanumGothic.ttf"
position_id = 3
label_datas = [
  {:column => "name", :y_pos => 1987, 
  :color => color, :position_id => p_id, :x_pos => x_pos, :size => size, :gravity => gravity, :font => font}, 
  {:column => "item_code", :y_pos => 2006,
  :color => color, :position_id => p_id, :x_pos => x_pos, :size => size, :gravity => gravity, :font => font}, 
  {:column => "description", :y_pos => 2042,
  :color => color, :position_id => p_id, :x_pos => x_pos, :size => size, :gravity => gravity, :font => font}, 
  {:column => "color", :y_pos => 2182,
  :color => color, :position_id => p_id, :x_pos => x_pos, :size => size, :gravity => gravity, :font => font}, 
  {:column => "size", :y_pos => 2238,
  :color => color, :position_id => p_id, :x_pos => x_pos, :size => size, :gravity => gravity, :font => font}, 
  {:column => "fabric", :y_pos => 2283,
  :color => color, :position_id => p_id, :x_pos => x_pos, :size => size, :gravity => gravity, :font => font}
]
label_datas.each do |label_data|
  Label.create(
  {
    position_id: p_id,
    size: size,
    color: color,
    gravity: gravity,
    x_pos: x_pos,
    y_pos: label_data[:y_pos],
    column: label_data[:column],
    font: font
  }
)
end

puts "레이블 " + Label.count.to_s + "개 생성"

puts Template.first.name + ' 템플릿 생성완료'

Position.association_to_the_template(User.find(3))

photos = ['bg-part1-3.png']

Photo.create(:photo_file => open(Rails.root.to_s + "/db/photos/" + 'bg-part1-3.png'), 
:template_id => Template.last.id, :mold_id => Mold.find(1).id, :part => 100)