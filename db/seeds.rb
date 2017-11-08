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

photos_array

5.times do
  User.create(
    name: Faker::WorldOfWarcraft.hero,
    email: Faker::Internet.email,
    password: 'test123'
  )
end

5.times do
  Brand.create(
    name: Faker::Pokemon.name,
    logo: %w(nike adidas puma).sample,
    link: 'https://store.nike.com/sg/en_gb/pw/new-mens/meZ7pu'
  )
end

5.times do
  Photo.create(
    title: Faker::LordOfTheRings.character,
    description: Faker::LordOfTheRings.location,
    photo_link: 'https://i.pinimg.com/736x/2e/e2/4f/2ee24f990d394ab4762900b9a66e5c6c--adidas-mens-clothing-adidas-outfits-men.jpg',
    user_id: User.all.sample.id,
    brand_id: Brand.all.sample.id,
    points: [*0..100].sample
  )
end

5.times do
  Message.create(
    content: Faker::WorldOfWarcraft.quote,
    message_type: [0, 1].sample,
    user_id: User.all.sample.id,
    photo_id: Photo.all.sample.id
  )
end
