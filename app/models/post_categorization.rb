class PostCategorization < ActiveRecord::Base
  # Links back
  belongs_to :post, class_name: 'Post'
  belongs_to :post_category, class_name: 'PostCategory'

  # Validations
  validates_presence_of :post, :post_category
end
