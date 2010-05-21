class AddPricesToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :active_sell_price_id, :integer
    add_column :products, :active_buy_price_id, :integer
  #  remove_column :products, :price
  end

  def self.down
    
  end
end
