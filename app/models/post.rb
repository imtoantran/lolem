class Post < ActiveRecord::Base
  # has_permalink :title
  # All customers ordered by their ID desending
  scope :ordered, -> { order(id: :desc)}
  # Return attachment for the default_image role
  #
  # @return [String]
  def default_image
    self.attachments.for("default_image")
  end

  # Set attachment for the default_image role
  def default_image_file=(file)
    self.attachments.build(file: file, role: 'default_image')
  end

  # Attachments for this post
  has_many :attachments, as: :parent, dependent: :destroy, autosave: true, class_name: "Shoppe::Attachment"
  # The product's categorizations
  #
  # @return [Shoppe::ProductCategorization]
  has_many :post_categorizations, dependent: :destroy, class_name: 'PostCategorization', inverse_of: :post
  # The product's categories
  #
  # @return [PostCategory]
  has_many :post_categories, class_name: 'PostCategory', through: :post_categorizations

  def attachments=(attrs)
    if attrs["default_image"]["file"].present? then self.attachments.build(attrs["default_image"]) end
  end
  # Return the first product category
  #
  # @return [Shoppe::ProductCategory]
  def post_category
    post_categories.first
  rescue
    nil
  end
  # All active posts
  scope :active, -> { where(active: true) }
  validates :title, presence: true
  validates :permalink, presence: true, uniqueness: true, permalink: true
  # Before validation, set the permalink if we don't already have one
  before_validation { self.permalink = title.parameterize if permalink.blank? && title.is_a?(String) }
end
