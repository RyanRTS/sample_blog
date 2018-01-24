User.create!(name:  Faker::Name.name,
             email: "example@gmail.com",
             password:              "password",
             password_confirmation: "password")
             
User.create!(name:  Faker::Name.name,
             email: "example2@gmail.com",
             password:              "password",
             password_confirmation: "password")
             
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
             email: email,
             password:              password,
             password_confirmation: password)
end

#posts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.paragraph
  title = Faker::Lorem.sentence(3)
  users.each { |user| user.posts.create(title: title, content: content) }
end