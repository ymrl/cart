require 'csv'
require 'yaml'

class Tasks::InsertIngredientsAndCommodities
  def self.execute
    ingredient_fixture = {}
    commodity_fixture = {}
    CSV.foreach("#{Rails.root}/lib/assets/commodities.csv") do |row|
      ingredient_attributes = {
        :name          => row[0],
        :calorie       => row[2],
        :carbohydrates => row[3],
        :protein       => row[4],
        :fat           => row[5],
        :carotene      => row[6],
        :vitamin_b1    => row[7],
        :vitamin_b2    => row[8],
        :vitamin_c     => row[9],
        :calcium       => row[10],
      }

      commodity_attributes = {
        :weight      => row[1],
        :price       => row[11],
        :producer    => row[12],
        :description => row[13],
        :jan         => row[14],
      }
      p ingredient_attributes
      p commodity_attributes

      ingredient = Ingredient.find_by_name(ingredient_attributes[:name])
      if ingredient
        ingredient.update_attributes!(ingredient_attributes)
      else
        ingredient = Ingredient.create!(ingredient_attributes)
      end

      ingredient_attributes[:id] = ingredient.id
      commodity_attributes[:ingredient_id] = ingredient.id

      commodity = Commodity.find_by_jan(commodity_attributes[:jan])
      if commodity
        commodity.update_attributes!(commodity_attributes)
      else
        commodity = Commodity.create!(commodity_attributes)
      end

      commodity_attributes[:commodity_id] = commodity.id


      ingredient_fixture[ingredient.id.to_s] = ingredient_attributes
      commodity_fixture[commodity.id.to_s] = commodity_attributes
    end
    File.open("#{Rails.root}/spec/fixtures/ingredients.yml","w") {|file| file.puts YAML.dump(ingredient_fixture)}
    File.open("#{Rails.root}/spec/fixtures/commodities.yml","w") {|file| file.puts YAML.dump(commodity_fixture)}
  end
end

