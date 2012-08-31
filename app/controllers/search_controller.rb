class SearchController < ApplicationController
  def index
    @ingredients = Ingredient.all
  end
end
