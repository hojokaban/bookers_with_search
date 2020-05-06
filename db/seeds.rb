User.create!(name: "Luffy",
	         introduction: "kaizokuou ni ore wa naru",
	         email: "luffy@example.com",
	         password: "password")

29.times do |n|
	name = Faker::Name.name[0..19]
	introduction = Faker::Lorem.sentence[0..49]
	email = "user-#{n+1}@example.com"
	password = "password"
	User.create!(name: name,
	         introduction: introduction,
	         email: email,
	         password: password)
end

29.times do |n|
	title = Faker::Cannabis.type
	body = Faker::Food.dish[0..199]
	Book.create!(title: title,
		         body: body,
		          user_id: n + 2)
end


users = User.all
user = users.first
following = users[2..29]
followers = users[3..19]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }