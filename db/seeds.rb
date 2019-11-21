require 'open-uri'
require 'json'

Dose.destroy_all
puts "Destroying all doses"

Ingredient.destroy_all
puts "Destroying all ingredients"

Cocktail.destroy_all
puts "Destroying all cocktails"

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

serialized_ingredients = open(url).read

ingredients = JSON.parse(serialized_ingredients)

ingredients['drinks'].each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

Ingredient.create(name: 'Ginger Beer')

Cocktail.create!(name: 'Moquito')
Cocktail.create!(name: 'Sex on the Beach')
Cocktail.create!(name: 'Moscow Mule')

Dose.create!(
  description: '6cl',
  cocktail_id: Cocktail.find_by(name: 'Moscow Mule').id,
  ingredient_id: Ingredient.find_by(name: 'Vodka').id
)

Dose.create!(
  description: '9cl',
  cocktail_id: Cocktail.find_by(name: 'Moscow Mule').id,
  ingredient_id: Ingredient.find_by(name: 'Ginger Beer').id
)
