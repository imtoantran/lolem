class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :full_content
      t.integer :user_id
      t.timestamps null: false
      t.string :permalink
    end
    add_index :posts, [:user_id, :created_at]
    add_index :posts, :permalink
  end
end
