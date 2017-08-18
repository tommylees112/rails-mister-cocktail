# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
# require 'open-uri'
require 'rest-client'

Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

Ingredient.create(name: "lemon")
Ingredient.create(name: "ice")
Ingredient.create(name: "mint leaves")

# json["drinks"].class

url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
cocktails_hash = RestClient.get "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list" # RestClient::Response class
ingredients_hash = JSON.parse(cocktails_hash)
# hash with nested array of hashes => {[{},{},{}}
#turn into an array
ingredients_array = ingredients_hash["drinks"]
ingredients = []

#iterate over an array
ingredients_array.each do |ingredient|
   Ingredient.create(name:ingredient["strIngredient1"])
   ingredients << ingredient["strIngredient1"]
end

# CREATE Doses and Cocktials
10.times do
  # create cocktail
  cocktail_name = Faker::Superhero.name
  cocktail = Cocktail.new(name: cocktail_name)
  3.times do
    dose_description = Faker::Measurement.metric_volume
    ingredient = Ingredient.find_by name: ingredients.sample
    dose = Dose.create(description: dose_description, cocktail: cocktail,ingredient: ingredient)
  end
  ## link doses to one cocktail and to one ingredient
  cocktail.save
end


### USING OPEN URI
# puts 'Seeding database...'
# url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# text = open(url).read
# # .read extract the json file & accesses the text
# ingredients = JSON.parse(text)
# # .parse will transform from json to a hash

# ingredients["drinks"].each do |ingredient|
#   Ingredient.create(name: ingredient["strIngredient1"])
# end
# puts 'Finished!'
