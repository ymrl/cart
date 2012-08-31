require 'csv'
require 'yaml'

class Tasks::InsertIngredients
  def self.execute
    fixture = {}
    CSV.foreach("#{Rails.root}/lib/assets/ingredients.csv") do |row|
      attributes = {
        :name          => row[0],
        :calorie       => row[1],
        :carbohydrates => row[2],
        :protein       => row[3],
        :fat           => row[4],
        :carotene      => row[5],
        :vitamin_b1    => row[6],
        :vitamin_b2    => row[7],
        :vitamin_c     => row[8],
        :calcium       => row[9],
      }
      ingredient = Ingredient.find_by_name(attributes[:name])
      if ingredient
        ingredient.update_attributes!(attributes)
      else
        ingredient = Ingredient.create!(attributes)
      end
      attributes[:id] = ingredient.id
      fixture[ingredient.id.to_s] = attributes
    end
    File.open("#{Rails.root}/spec/fixtures/ingredients.yml","w") do |file|
      file.puts YAML.dump(fixture)
    end
  end
end

