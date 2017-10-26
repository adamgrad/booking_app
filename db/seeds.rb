User.create!(name:  "Admin User",
             email: "admin@user.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "fake-#{n+1}@user.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end