# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create!(name: "Food")
Category.create!(name: "Drinks")

Business.create!(name: "Motorino", description: "Rustic pizza", category_id: 1, small_cover_url: "/tmp/MO.jpg")
Business.create!(name: "Jumbo", description: "Floating restaurant", category_id: 1, small_cover_url: "/tmp/Jumbo.jpg")
Business.create!(name: "Blue Hill", description: "Magical dining hall", category_id: 1, small_cover_url: "/tmp/BlueHill.jpg")

Business.create!(name: "MO Bar", description: "Mandarin Oriental bar", category_id: 2, small_cover_url: "/tmp/MO-Bar.jpg")