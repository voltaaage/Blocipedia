# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create admin
admin = User.new(
  name: 'Administrator',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
)
admin.skip_confirmation!
admin.save!

# Create premium
premium = User.new(
  name: 'Premium Member',
  email: 'premium@example.com',
  password: 'helloworld',
  role: 'premium'
)
premium.skip_confirmation!
premium.save!

# Create standard
standard = User.new(
  name: 'Standard User',
  email: 'standard@example.com',
  password: 'helloworld',
  role: 'standard'
)
standard.skip_confirmation!
standard.save!

# Create users
10.times do
  user = User.new(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: 'helloworld'
  )
  user.skip_confirmation!
  user.save!
end

users = User.all

# Create wikis
50.times do 
  wiki = Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: false
  )
  for i in 0..rand(5)
    collaborater = Collaborator.new(
        wiki_id: wiki.id,
        user_id: users.sample.id
    )
    collaborater.save!
  end
end

puts "#{User.count} users were created."
puts "#{Wiki.count} users were created."
puts "#{Collaborator.count} collaborator objects were created."