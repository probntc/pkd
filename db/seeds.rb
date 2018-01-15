User.create!(
  name: "Master",
  email: "master@mail.com",
  password: "12345678",
  password_confirmation: "12345678",
  sex: 0,
  admin: true
  )

99.times do |n|
  name = Faker::Name.name
  email = "master#{n+1}@mail.org"
  password = "12345678"
  sex = Faker::Number.between(0, 1)
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    sex: sex,
    )
end
