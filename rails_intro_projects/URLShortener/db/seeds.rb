# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do


User.destroy_all
user1 = User.create(email: "gmail")
user2 = User.create(email: "yahoo")
user3 = User.create(email: "outlook")


ShortenedUrl.destroy_all
shorturl1 = ShortenedUrl.create!(user1, "https.www.google.com/mail/gmail")
shorturl2 = ShortenedUrl.create!(user2, "https:www.blizzard.com")
shorturl3 = ShortenedUrl.create!(user3, "https:www.ddrfreak.com")
shorturl4 = ShortenedUrl.create!(user3, "https:www.espn.com")
shorturl5 = ShortenedUrl.create!(user3, "https:www.cnn.com")

Visit.destroy_all
visit1= Visit.record_visit!(user1,shorturl1)
visit2= Visit.record_visit!(user1,shorturl2)
visit3= Visit.record_visit!(user1,shorturl2)
visit4= Visit.record_visit!(user1,shorturl3)
visit5= Visit.record_visit!(user2,shorturl3)
visit6= Visit.record_visit!(user2,shorturl3)
visit7= Visit.record_visit!(user2,shorturl4)
visit8= Visit.record_visit!(user2,shorturl4)
visit9= Visit.record_visit!(user2,shorturl4)
visit10= Visit.record_visit!(user2,shorturl4)
visit11= Visit.record_visit!(user2,shorturl5)
visit12= Visit.record_visit!(user2,shorturl5)
visit13= Visit.record_visit!(user2,shorturl5)
visit14= Visit.record_visit!(user2,shorturl5)
visit15= Visit.record_visit!(user2,shorturl5)

TagTopic.destroy_all
topic1 = TagTopic.create(topic: "news")
topic2 = TagTopic.create(topic: "sports")
topic3 = TagTopic.create(topic: "music")
topic4 = TagTopic.create(topic: "email")
topic5 = TagTopic.create(topic: "games")

Tagging.destroy_all
tag1 = Tagging.create(url_id: shorturl1.id, tag_id: topic1.id)
tag2 = Tagging.create(url_id: shorturl2.id, tag_id: topic1.id)
tag3 = Tagging.create(url_id: shorturl3.id, tag_id: topic1.id)
tag4 = Tagging.create(url_id: shorturl4.id, tag_id: topic1.id)
tag5 = Tagging.create(url_id: shorturl5.id, tag_id: topic1.id)

end
