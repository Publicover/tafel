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

team = Team.create(name: 'Fightin Buckeyes')
team.logo.attach(io: File.open('test/fixtures/files/thumbs_up_batman.jpeg'),
                 filename: 'thumbs_up_batman.jpeg',
                 content_type: 'image/jpg')
team.save

puts "Creating a team with two other users..."

User.create(email: 'dana@pubchalk.com', f_name: 'Dana', l_name: 'Pub', role: :captain,
            password: 'password', team_id: team.id)
User.create(email: 'mike@pubchalk.com', f_name: 'Mike', l_name: 'Pub', role: :player,
            password: 'password', team_id: team.id)

puts "And another with two more..."

other_team = Team.create(name: 'Ohio Players')
other_team.logo.attach(io: File.open('test/fixtures/files/t2_fire_thumbs_up.jpg'),
                       filename: 't2_fire_thumbs_up.jpg',
                       content_type: 'image/jpg')
other_team.save

User.create(email: 'someguy@team.com', f_name: 'Some', l_name: 'Guy', role: :captain,
            password: 'password', team_id: other_team.id)
User.create(email: 'otherguy@team.com', f_name: 'Other', l_name: 'Guy', role: :player,
            password: 'password', team_id: other_team.id)

puts 'Creating 2 games...'

first_game = Game.create!(name: 'Cricket', schedule_date: Time.zone.today, team_ids: [team.id, other_team.id])
Score.create!(points: 11, game_id: first_game.id, team_id: team.id)
Score.create!(points: 12, game_id: first_game.id, team_id: other_team.id)

puts "With some scores..."

second_game = Game.create!(name: '501', schedule_date: Time.zone.tomorrow, team_ids: [team.id, other_team.id])
Score.create!(points: 21, game_id: second_game.id, team_id: team.id)
Score.create!(points: 22, game_id: second_game.id, team_id: other_team.id)

puts "Seeds complete!"
