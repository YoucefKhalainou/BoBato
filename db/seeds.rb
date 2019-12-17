# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
cities = ["Toulouse", "Lorient", "Nice", "Paris", "Bordeaux", "Lyon", "Bastia", "Biarritz", "Gap", "Clermont-Ferrand", "Strasbourg", "Saint-Malo", "Dinard", "La Rochelle", "Honfleur", "Deauville", "Rennes", "Nantes", "Cannes"]
boats = ["Yacht", "Catamaran", "Voilier", "Chalutier", "Péniche", "Bateau-corsaire", "Deux-mâts", "Trois-mâts", "Bâteau cabine", "Croiseur", "Hors-Bord", "Bateau maison"]
departure_ports = ["Marseille", "Mykonos", "Barcelone", "Athènes", "Tanger", "Genes", "Hambourg", "Rotterdam", "Amsterdam", "Saint-Nazaire", "Le Havre", "Bizerte", "Brighton"]
arrival_ports = ["Toulon", "Ajaccio", "Bonifacio", "Split", "Palerme", "Dubrovnik", "Le Pirée", "Malaga", "Ibiza", "Hyères", "Naples", "Syracuse", "Trapani", "Lipari", "Cagliari"]

35.times do |i|
	User.create(
							email: Faker::Internet.email, 
							password: 'AZERTY'
							)
	puts "User #{i+1} seeded"

	p = Profile.find(i+1)
	p.update(
					first_name: Faker::Name.first_name,
					last_name: Faker::Name.last_name,
					birthdate: Date.new(rand(1974..2000), rand(1..12), rand(1..28)),
					city: cities.sample,
					description: Faker::Lorem.paragraph(sentence_count: 5),
					)
	p.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "person_#{(i%40)+1}.png")), filename: "person_#{(i%40)+1}.png")
	puts "Profile #{i+1} seeded"
end


#Convoys with closed submission
j = 0
5.times do |i|
	#Creation of the convoy
	c = Convoy.create(
										boat_owner: User.find(i+1), 
										title: Faker::Movies::HitchhikersGuideToTheGalaxy.starship, 
										description: Faker::Lorem.paragraph,
										boat_type: boats.sample, 
										required_license: "Tous permis",
										departure_port: departure_ports.sample,
										arrival_port: arrival_ports.sample, 
										date_of_departure: Date.new(2020, rand(1..4), rand(1..28)), 
										date_of_arrival: Date.new(2020, rand(5..9), rand(1..28)), 
										convoy_price: rand(2000..10000)
										)
	#Attachment of the picture
	c.pictures.attach(io: File.open(Rails.root.join("app", "assets", "images", "#{(i%26)+1}.png")), filename: "#{(i%26)+1}.png")
	puts "Convoy #{c.id} seeded"

	#Creation of 2 rejected submissions
	2.times do 
	s = Submission.create(
										skipper: User.find(j+6), 
										convoy: c,
										cover_text: Faker::Lorem.paragraph(sentence_count: 4),
										status: false,
										)
	puts "Submission #{s.id} seeded"
	j+=1
	end

	#Creation of 1 accepted submissions
	s = Submission.create(
										skipper: User.find(j+6), 
										convoy: c,
										cover_text: Faker::Lorem.paragraph(sentence_count: 4),
										status: true,
										)
	puts "Submission #{s.id} seeded"

	#Creation of the associated delivery (submission closed for Convoy c)
	d = Delivery.create(
								skipper: User.find(j+6), 
								convoy: c,
								stripe_id: (i+1)*rand(1..23134)
								)
	puts "Delivery #{d.id} seeded"
	j+=1
end


#Convoys with opened submission (no delivery yet)
j = 0
5.times do |i|
	#Creation of the convoy
	c = Convoy.create(
										boat_owner: User.find(i+1), 
										title: Faker::Movies::HitchhikersGuideToTheGalaxy.starship, 
										description: Faker::Lorem.paragraph,
										boat_type: boats.sample, 
										required_license: "Tous permis",
										departure_port: departure_ports.sample,
										arrival_port: arrival_ports.sample, 
										date_of_departure: Date.new(2020, rand(1..4), rand(1..28)), 
										date_of_arrival: Date.new(2020, rand(5..9), rand(1..28)), 
										convoy_price: rand(2000..10000)
										)
	#Attachment of the picture
	c.pictures.attach(io: File.open(Rails.root.join("app", "assets", "images", "#{(i+6)%26+1}.png")), filename: "#{(i+6)%26+1}.png")
	puts "Convoy #{c.id} seeded"

	#Creation of 2 submissions
	2.times do 
	s = Submission.create(
										skipper: User.find(j+21), 
										convoy: c,
										cover_text: Faker::Lorem.paragraph(sentence_count: 4),
										)
	puts "Submission #{s.id} seeded"
	j+=1
	end
end


35.times do |i|
	r = Comment.create(
										user: User.find(rand(1..20)), 
										recipient: User.find(rand(21..35)), 
										rating: rand(1..5), 
										review: Faker::Lorem.paragraph(sentence_count: 4))
	puts "Comment #{r.id} seeded"

	r = Comment.create(
										user: User.find(rand(21..35)), 
										recipient: User.find(rand(1..20)), 
										rating: rand(1..5), 
										review: Faker::Lorem.paragraph(sentence_count: 4))
	puts "Comment #{r.id} seeded"
end

# Set tags for all created convoys
Convoy.all.each_with_index do |c, i|
	c.update(departure_port_list: c.departure_port)
	c.update(boat_type_list: c.boat_type)
end





