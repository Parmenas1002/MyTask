10.times do |n|
    name = "User number " + n.to_s
    email = "user" + n.to_s + "@gmail.com"
    password = "mypassword"
    User.create!(name: name,
                email: email,
                password: password)
end

10.times do |n|
    title = "My task " + n.to_s
    description = "Description of Task number " + n.to_s
    Task.create!(title: title,
                 description: description,
                 status: 0,
                 priority: 0,
                 user: User.first)
end