class CreatePostCategories < ActiveRecord::Migration
  def change
    create_table :post_categories do |t|
      t.string :name
      t.string :permalink
      t.string :description
      t.integer :parent_id
      t.integer :depth
      t.string :ancestral_permalink
      t.timestamps null: false
    end
  end
end
