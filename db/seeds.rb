User.create!(name: "Luffy",
	         introduction: "kaizokuou ni ore wa naru"
	         email: "luffy@example.com"
	         encrypted_password: "password")

29.times do |n|
	name = Faker::Name.name
	introduction = Faker::Lorem.sentence
	email = "user-#{n+1}@example.com"
	password = "password"
	User.create!(name: name,
	         introduction: introduction
	         email: email
	         encrypted_password: password)


users = User.all
user = users.first
following = users[2..29]
followers = users[3..19]
following.each{ |followed| user.follow(followed)}
followers.each{ |follower| follower.follow(user)}