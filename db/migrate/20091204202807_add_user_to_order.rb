class AddUserToOrder < ActiveRecord::Migration
  def self.up

    execute "ALTER TABLE ONLY line_items DROP CONSTRAINT fk_line_item_orders"
    drop_table :orders
    LineItem.delete_all

    create_table :orders do |t|
      t.integer :user_id, :null => false

    end

    execute "ALTER TABLE ONLY line_items
             ADD CONSTRAINT fk_line_item_orders FOREIGN KEY (order_id) REFERENCES orders(id)"

  end

  def self.down
  end
end
