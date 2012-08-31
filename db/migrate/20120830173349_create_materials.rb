class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.references :recipe
      t.string :name
      t.string :amount

      t.timestamps
    end
    add_index :materials, :recipe_id
  end
end
