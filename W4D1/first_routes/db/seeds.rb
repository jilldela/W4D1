# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
user1 = User.create(username: 'garyeh')
user2 = User.create(username: 'jilldela')
user3 = User.create(username: 'sam')
user4 = User.create(username: 'jules')


Artwork.destroy_all
art1 = Artwork.create(title: 'waves', image_url: 'waves.jpg', artist_id: user2.id)
art2 = Artwork.create(title: 'rocks', image_url: 'rocks.jpg', artist_id: user2.id)
art3 = Artwork.create(title: 'paper', image_url: 'paper.jpg', artist_id: user1.id)

ArtworkShare.destroy_all
share1 = ArtworkShare.create(artwork_id: art1.id, viewer_id: user1.id)
