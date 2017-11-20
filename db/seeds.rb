# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Faker::Config.locale = 'nl'

companies = [{ name: 'Sprout', address: 'Enterij 58', zipcode: '2771MX', country: 'Nederland', city: 'Boskoop' }]
49.times do |index|
    companies.push({
        name: Faker::Company.name,
        address: Faker::Address.street_address,
        zipcode: Faker::Address.zip_code,
        country: 'Nederland',
        city: Faker::Address.city
    })
end
companies = Company.create!(companies)
puts "Created #{companies.count} companies"

users = [{email: 'd.rosbergen@gmail.com', password: 'Welkom#1', company: companies.first}]
99.times do |index|
    users.push({
        email: "d.rosbergen+#{Faker::Internet.unique.user_name}@gmail.com",
        password: "Welkom#1",
        company: companies.sample
    })
end
users = User.create!(users)
puts "Created #{users.count} users"