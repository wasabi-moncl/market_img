# coding : utf-8

User.destroy_all
Template.destroy_all
Position.destroy_all
Photo.destroy_all

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
      name: "ilcorso"
    }
  ]
)
5.times do |i|
  name = "ilcorso_" + i.to_s
  template_id = Template.last.id
  p = Position.create(
  [
    {
      name: name,
      part: i,
      template_id: template_id,
      x_pos: 1,
      y_pos: 550 * i + 1,
      width: 550,
      height: 550
    }
  ]
)
end
puts'"ilcorso" 템플릿 생성완료'
Position.association_to_the_template


photos = ['MC1G2D401DB.png',   'MC1G2D403GE_1.png',  'MCD02D409BL.png',    'MCD02D503GE_1.png',
'MC1G2D401DB_1.png',  'MC1G2D403MT.png',    'MCD02D409BL_1.png',  'MCD02D503KK.png',
'MC1G2D402GE.png',    'MC1G2D403MT_1.png',  'MCD02D409IV.png',    'MCD02D503KK_1.png',
'MC1G2D402GE_1.png',  'MCD01D908NV.png',    'MCD02D409IV_1.png',  'MCH02C301DI.png',
'MC1G2D403GE.png',    'MCD01D908NV_1.png',  'MCD02D503GE.png',    'MCH02C301DI_1.png' ]

photos.each do |x|
  Photo.create(:photo_file => open(Rails.root.to_s + "/db/photos/" + x), :user_id => User.first.id)
end

  
  

