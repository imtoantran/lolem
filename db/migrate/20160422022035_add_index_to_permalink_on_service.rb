class AddIndexToPermalinkOnService < ActiveRecord::Migration
  def change
    add_index :services, :permalink
  end
end
