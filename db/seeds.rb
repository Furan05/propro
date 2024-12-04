require 'faker'

puts "start seeding"

# Supprimer les enregistrements existants
puts "Cleaning database..."
DaddyService.destroy_all
User.destroy_all
Category.destroy_all

# Générer des utilisateurs
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    username: Faker::Internet.username,
    role: [true, false].sample
  )
  puts "user created"
end

# Générer des catégories
categories = ["informatique", "mecano", "menuiserie", "btp", "styling"]
categories.each do |category_name|
  Category.create!(name: category_name)
  puts "category #{category_name} created"
end

puts "Creating services..."

users = User.all
categories = Category.all

15.times do
  service = DaddyService.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: rand(50..500),
    user: users.sample,
    category: categories.sample
  )
  puts "Created service: #{service.title}"
end

puts "end seeding"
