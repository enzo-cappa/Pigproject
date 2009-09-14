class CreateLineItems < ActiveRecord::Migration
  def self.up
    create_table :line_items do |t|
      t.integer :product_id, :null => false
      t.integer :order_id, :null => false
      t.integer :quantity, :null => false
      t.decimal :total_price, :null => false, :precision => 8, :scale => 2

      t.timestamps
    end
    execute "ALTER TABLE ONLY line_items
             ADD CONSTRAINT fk_line_item_products FOREIGN KEY (product_id) REFERENCES products(id)"
    execute "ALTER TABLE ONLY line_items
             ADD CONSTRAINT fk_line_item_orders FOREIGN KEY (order_id) REFERENCES orders(id)"
  end

  def self.down
    drop_table :line_items
  end
end
