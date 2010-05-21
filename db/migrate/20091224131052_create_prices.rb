class CreatePrices < ActiveRecord::Migration
  def self.up
    create_table :prices do |t|
      t.decimal :price
      t.integer :product_id, :null => false
      t.text    :type, :null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :prices
  end
end
