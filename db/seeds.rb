User.create! name:  "Admin_system",
  email: "adminsystem@gmail.com",
  address: "Handico_OE9_R",
  password: "111111",
  password_confirmation: "111111",
  admin: true,
  activated: true,
  activated_at: Time.zone.now

User.create! name: "Admin_system1",
  email: "adminsystem1@gmail.com",
  address: "Handico_OE9_R1",
  password: "111111",
  password_confirmation: "111111",
  admin: true,
  activated: true,
  activated_at: Time.zone.now

30.times do |n|
  name = FFaker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  address = "address-#{n+1}"
  User.create! name: name,
    email: email,
    address: address,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
end

20.times do
  name =  FFaker::Book.genre
  Category.create! name: name
end

20.times do
  name = FFaker::Book.unique.author
  Author.create! name: name
end

50.times do |n|
  title = FFaker::Book.title
  num_page = "#{n+100}"
  avg_rate = "0.6"
  description = FFaker::Book.description sentence_count = 3
  category_id = rand 1..5
  author_id = rand 1..12
  Book.create! title: title,
    num_page: num_page,
    avg_rate: avg_rate,
    description: description,
    category_id: category_id,
    author_id: author_id
end

users = User.order(:created_at).take(6)
20.times do
  content = FFaker::Lorem.sentence(5)
  users.each {|user| user.feedbacks.create!(content: content)}
end

books = Book.order(:created_at).take(6)
20.times do
  content = FFaker::Lorem.sentence(5)
  user_id = rand 1..10
  num_rate = rand 1..5
  books.each {|book| book.reviews.create!(content: content, num_rate: num_rate, user_id: user_id)}
end
