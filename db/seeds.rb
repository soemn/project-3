# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Message.destroy_all
Photo.destroy_all
Brand.destroy_all
User.destroy_all

10.times do
  User.create(
    name: Faker::WorldOfWarcraft.hero,
    email: Faker::Internet.email,
    password: 'test123'
  )
end

10.times do
  Brand.create(
    name: Faker::Pokemon.name,
    logo: %w(nike adidas puma).sample,
    link: 'https://store.nike.com/sg/en_gb/pw/new-mens/meZ7pu'
  )
end

photo_array = [
  'https://www.thenational.ae/image/policy:1.208767:1499316145/image/jpeg.jpg?f=16x9&w=1024&$p$f$w=2589da4', 'https://i.pinimg.com/736x/2e/e2/4f/2ee24f990d394ab4762900b9a66e5c6c--adidas-mens-clothing-adidas-outfits-men.jpg',
  'http://www3.pictures.zimbio.com/bg/Kendall+Jenner+Celebrity+Social+Media+Pics+39cT5k6XvhNl.jpg',
  'http://us.hellomagazine.com/images/stories/1/2016/08/25/000/224/399/gallery_1_1.jpg',
  'http://celebmafia.com/wp-content/uploads/2017/02/emily-ratajkowski-pics-celebrity-social-media-2-23-2017-1.jpg',
  'https://assets.pcmag.com/media/images/515140-celebrity-endorsement-social-media-fails.png?thumb=y&width=694&height=694&boxFit=y'
]

10.times do
  Photo.create(
    title: Faker::LordOfTheRings.character,
    description: Faker::LordOfTheRings.location,
    photo_link: photo_array.sample,
    user_id: User.all.sample.id,
    brand_id: Brand.all.sample.id,
    points: [*0..100].sample
  )
end

10.times do
  Message.create(
    content: Faker::WorldOfWarcraft.quote,
    message_type: [0, 1].sample,
    user_id: User.all.sample.id,
    photo_id: Photo.all.sample.id
  )
end
