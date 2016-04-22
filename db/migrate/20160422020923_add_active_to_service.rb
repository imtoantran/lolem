class AddActiveToService < ActiveRecord::Migration
  def self.up
    add_column :services, :active, :integer
  end
  def self.down
    remove_column :services, :active
  end
end
