class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.string :jan
      t.integer :price
      t.references :ingredient
      t.float :weight
      t.text :description

      t.timestamps
    end
    add_index :commodities, :ingredient_id
  end
end
