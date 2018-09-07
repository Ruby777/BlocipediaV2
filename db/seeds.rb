require 'faker'

#Create Users
10.times do
    User.create do | user |
        user.email = Faker::Internet.email
        user.password = Faker::Internet.password(10)
    end
end
users = User.all

#Create Wikis
50.times do
    Wiki.create do | wiki |
        wiki.title = Faker::Lorem.sentence
        wiki.body = Faker::Lorem.paragraph
        wiki.user = users.sample
    end
end
wikis = Wiki.all




puts "Seed Finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
