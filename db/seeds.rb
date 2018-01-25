User.create!(name:  Faker::Name.name,
             email: "example@gmail.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)
             
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

#categories

Category.create!(name: "Misc", user: User.first)

9.times do 
  user = User.find(Faker::Number.between(1,3))
  name = Faker::Hipster.words(2).join(' ')
  Category.create!(name: name, user: user)
end

#posts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.paragraph
  title = Faker::Lorem.sentence(3)
  category = Faker::Number.between(1,10)
  users.each { |user| user.posts.create(title: title, content: content, category: Category.find(category)) }
end