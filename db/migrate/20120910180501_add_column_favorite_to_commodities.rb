class AddColumnFavoriteToCommodities < ActiveRecord::Migration
  def change
    add_column :commodities, :favorites, :integer, :default => 0
  end
end
