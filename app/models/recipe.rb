class Recipe < ActiveRecord::Base
  attr_accessible :calorie, :image, :time, :title, :url, :ingredients, :materials
  validates :url,   :presence => true,:uniqueness => true
  validates :image, :presence => true

  has_many :materials
  has_many :recipe_ingredients
  has_many :ingredients, :through => :recipe_ingredients
 
end
