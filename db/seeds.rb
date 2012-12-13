# coding : utf-8

User.destroy_all
Template.destroy_all
Position.destroy_all

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

