class CreatePostCategorizations < ActiveRecord::Migration
  def change
    create_table :post_categorizations do |t|
      t.string :post_id
      t.string :post_category_id
      t.timestamps null: false
    end
  end
end
