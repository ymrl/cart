class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :calorie
      t.float :carbohydrates
      t.float :protein
      t.float :fat
      t.float :carotene
      t.float :vitamin_b1
      t.float :vitamin_b2
      t.float :vitamin_c
      t.float :calcium

      t.timestamps
    end
  end
end
