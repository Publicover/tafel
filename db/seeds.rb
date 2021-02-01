# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Creating admin..."

User.create(email: 'jim@pubchalk.com', f_name: 'Jim', l_name: 'Pub', role: :admin,
            password: 'password')

puts "Creating two other users..."

User.create(email: 'dana@pubchalk.com', f_name: 'Dana', l_name: 'Pub', role: :captain,
            password: 'password')
User.create(email: 'mike@pubchalk.com', f_name: 'Mike', l_name: 'Pub', role: :player,
            password: 'password')

puts "And two more..."

User.create(email: 'someguy@team.com', f_name: 'Some', l_name: 'Guy', role: :captain,
            password: 'password')
User.create(email: 'otherguy@team.com', f_name: 'Other', l_name: 'Guy', role: :player,
            password: 'password')
