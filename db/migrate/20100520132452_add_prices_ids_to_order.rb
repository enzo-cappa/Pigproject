class AddPricesIdsToOrder < ActiveRecord::Migration
  def self.up
    add_column :line_items, :buy_price_id, :integer
  end

  def self.down
  end
end
