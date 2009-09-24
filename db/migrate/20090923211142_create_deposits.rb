class CreateDeposits < ActiveRecord::Migration
  def self.up
    create_table :deposits do |t|
      t.integer :user_id, :null => false
      t.decimal :amount, :null => false, :precision => 8, :scale => 2
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :deposits
  end
end
