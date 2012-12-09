# coding : utf-8

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
photos = Item.create(
[
  {
    name: '바지'
  }
])