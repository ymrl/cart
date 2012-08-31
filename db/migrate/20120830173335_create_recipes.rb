class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image
      t.string :url
      t.string :time
      t.float :calorie

      t.timestamps
    end
  end
end
