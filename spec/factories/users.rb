FactoryBot.define do
  factory :user do
    name { "Name" }
    email { "from@example.com" }
    password { "password" }
  end
  factory :admin, class: User do
    name { "Admin" }
    email { "admin@example.com" }
    password { "password" }
    admin {1}
  end
end
