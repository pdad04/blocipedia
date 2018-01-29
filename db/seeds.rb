require 'random_data'
require 'faker'

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

User.create!(
  email: "andre_dean@me.com",
  password: "nemito",
  role: 'premium'
)

User.create!(
  email: "andre_dean@icloud.com",
  password: "nemito"
)
users = User.all

# # Create topics
# 15.times do
#   Topic.create!(
#     name:         RandomData.random_sentence,
#     description:  RandomData.random_paragraph
#   )
# end
# topics = Topic.all

# Create Wiki's
5.times do
  wiki = Wiki.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, private: false, user: users.sample)
end

wikis = Wiki.all

# 100.times do
#   Comment.create!(
#     user: users.sample,
#     post: posts.sample,
#     body: RandomData.random_paragraph
#   )
# end
#
# admin = User.create!(
#   name:     'Admin User',
#   email:    'admin@example.com',
#   password: 'helloworld',
#   role:     'admin'
# )
#
# member = User.create!(
#   name:     'Member User',
#   email:    'member@example.com',
#   password: 'helloworld'
# )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
