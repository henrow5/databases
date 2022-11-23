require_relative "lib/database_connection"
require_relative "lib/recipe_repository"

DatabaseConnection.connect("recipes_directory")

recipe_repository = RecipeRepository.new

# recipe = recipe_repository.find(2)

# puts recipe.id
# puts recipe.name
# puts recipe.cooking_time
# puts recipe.rating

recipe_repository.all.each do |recipe|
  puts "#{recipe.id} - #{recipe.name} - #{recipe.cooking_time} minutes - Rating: #{recipe.rating}"
end
