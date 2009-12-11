class CreateAbstractUser < ActiveRecord::Migration
  def self.up
      execute "ALTER TABLE users RENAME TO abstract_users"
  end

  def self.down
  end
end
