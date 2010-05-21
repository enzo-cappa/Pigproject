class RenamePriceValueColumn < ActiveRecord::Migration
  def self.up
    rename_column :prices, :price, :value
  end

  def self.down
  end
end
