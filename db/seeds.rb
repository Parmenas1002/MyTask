10.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "mypassword"
    User.create!(name: name,
                email: email,
                password: password,)
end

10.times do |n|
    name = Faker::Games::Pokemon.name
    Tag.create!(name: name)
end