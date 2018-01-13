require 'random_data'
5.times do
  User.create!(
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

# # Create topics
# 15.times do
#   Topic.create!(
#     name:         RandomData.random_sentence,
#     description:  RandomData.random_paragraph
#   )
# end
# topics = Topic.all

# Create Posts
5.times do
  wiki = Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false, user: users.sample)
end

User.create!(
  email: "andre_dean@me.com",
  password: "nemito"
)

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
