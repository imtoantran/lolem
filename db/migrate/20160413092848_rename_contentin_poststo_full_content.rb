class RenameContentinPoststoFullContent < ActiveRecord::Migration
  def change
    rename_column :posts, :content, :full_content
  end
end
