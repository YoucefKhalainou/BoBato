# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# 35.times do |i|
# 	User.create(
# 							email: Faker::Internet.email, 
# 							password: 'AZERTY'
# 							)
# 	puts "User #{i+1} seeded"

# 	p = Profile.find(i+1)
# 	p.update(
# 					first_name: Faker::Name.first_name,
# 					last_name: Faker::Name.last_name,
# 					birthdate: DateTime.new(rand(1974..2000), rand(1..12), rand(1..28)),
# 					city: ["Toulouse", "Lorient", "Nice", "Paris", "Bordeaux", "Lyon"].sample,
# 					description: Faker::Lorem.paragraph,
# 					)
# 	p.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "person_#{(i%3)+1}.jpg")), filename: "person_#{(i%3)+1}.jpg")
# 	puts "Profile #{i+1} seeded"
# end


30.times do |i|
	c = Convoy.create(
										boat_owner: User.find(i+1), 
										title: Faker::Movies::HitchhikersGuideToTheGalaxy.starship, 
										description: Faker::Lorem.paragraph,
										boat_type: ["Yacht", "Catamaran", "Voilier"].sample, 
										required_license: "Tous permis",
										departure_port: ["Marseille", "Mykonos", "Barcelone", "Athènes", "Tanger", "Genes"].sample,
										arrival_port: ["Toulon", "Ajaccio", "Bonifacio", "Split", "Palerme", "Dubrovnik"].sample, 
										date_of_departure: DateTime.new(2020, rand(1..4), rand(1..28)), 
										date_of_arrival: DateTime.new(2020, rand(5..9), rand(1..28)), 
										convoy_price: rand(2000..10000)
										)
	c.pictures.attach(io: File.open(Rails.root.join("app", "assets", "images", "convoy_#{(i%6)+1}.png")), filename: "convoy_#{(i%6)+1}.png")
	puts "Convoy #{i+1} seeded"
end


# 10.times do |i|
# 	Submission.create(
# 										skipper: User.find(i+6), 
# 										convoy: Convoy.find((i/2)+1),
# 										cover_text: "Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus."
# 										)
# 	puts "Submission #{i+1} seeded"
# end


# 5.times do |i|
# 	Delivery.create(
# 									skipper: User.find(2*(i+3)+1), 
# 									convoy: Convoy.find(i+1),
# 									stripe_id: (i+1)*rand(1..23134)
# 									)
# 	Submission.find((2*i)+1).update(status: false)
# 	Submission.find(2*(i+1)).update(status: true)
# 	puts "Delivery #{i+1} seeded"
# end


