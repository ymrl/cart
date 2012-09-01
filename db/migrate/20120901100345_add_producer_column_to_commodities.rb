class AddProducerColumnToCommodities < ActiveRecord::Migration
  def change
    add_column :commodities, :producer,:string
  end
end
