require "recipe_repository"

def reset_recipes_table
  seed_sql = File.read("spec/seeds_recipes.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "recipes_directory_test" })
  connection.exec(seed_sql)
end

def clear_recipes_table
  seed_sql = File.read("spec/seeds_empty.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "recipes_directory_test" })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do
    reset_recipes_table
  end

  it "returns an empty array with no recipes in the DB" do
    clear_recipes_table
    repo = RecipeRepository.new
    recipes = repo.all
    expect(recipes).to eq([])
  end

  it "returns two recipes" do
    repo = RecipeRepository.new
    recipes = repo.all

    expect(recipes.length).to eq(2)

    expect(recipes.first.id).to eq("1")
    expect(recipes.first.name).to eq("Pancakes")
    expect(recipes.first.cooking_time).to eq("12")
    expect(recipes.first.rating).to eq("3")

    expect(recipes.last.id).to eq("2")
    expect(recipes.last.name).to eq("French Toast")
    expect(recipes.last.cooking_time).to eq("10")
    expect(recipes.last.rating).to eq("4")
  end

  it "returns a single recipe Pancakes" do
    repo = RecipeRepository.new
    recipe = repo.find(1)

    expect(recipe.id).to eq("1")
    expect(recipe.name).to eq("Pancakes")
    expect(recipe.cooking_time).to eq("12")
    expect(recipe.rating).to eq("3")
  end

  it "returns a single recipe French Toast" do
    repo = RecipeRepository.new
    recipe = repo.find(2)

    expect(recipe.id).to eq("2")
    expect(recipe.name).to eq("French Toast")
    expect(recipe.cooking_time).to eq("10")
    expect(recipe.rating).to eq("4")
  end
end
