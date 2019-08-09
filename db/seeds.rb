# 1000.times do |n|

  10.times do |n|
    title = Faker::Pokemon.name
    content = Faker::Pokemon.name
    sort_expired = Faker::Date.between(Date.today,2.years.later)
    status = Faker::Status.randomElement(['Untouched','Pending','Finished',''])
    # priority_color = Faker::Color.color_name

    Task.create!(title: title,
                 content: content,
                 status: status,
                 sort_expired: sort_expired,
                 )
  end

#   10.times do |n|
#     title = Faker::Color.name
# 省略
# end