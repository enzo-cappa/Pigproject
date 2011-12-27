class CreateAdminUser < ActiveRecord::Migration
  def up
    Administrator.create(:name => 'Admin', :password => 'admin')
  end

  def down
  end
end
