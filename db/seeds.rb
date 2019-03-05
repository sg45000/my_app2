# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

CSV.foreach('db/genre.csv')do |row|
    Genre.create!(name: row[0])
end

CSV.foreach('db/user.csv')do |row|
    User.create!(name: row[0],email: row[1],password: row[2],password_confirmation: row[3])
end

CSV.foreach('db/video.csv')do |row|
    Video.create!(user_id: row[0],name: row[1],url: row[2])
end