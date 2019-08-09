100.times do |n|
  title = Faker::Games::Pokemon.name
  content = Faker::Sports::Football
  sort_expired = Faker::Date
  Task.create!(title: title,
               content: content,
               sort_expired: sort_expired,
               )
end