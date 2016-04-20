class PostCategory < ActiveRecord::Base
  # All products within this category
  has_many :post_categorizations, dependent: :restrict_with_exception, class_name: 'PostCategorization', inverse_of: :post_category
  has_many :posts, class_name: 'Post', through: :post_categorizations
  translates :name, :permalink, :description
  scope :ordered, -> { includes(:translations).order(:name) }
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
  def attachments=(attrs)
    if attrs["default_image"]["file"].present? then self.attachments.build(attrs["default_image"]) end
  end
  # Attachment with the role image
  #
  # @return [String]
  def image
    attachments.for('image')
  end

  # No descendants
  scope :except_descendants, ->(record) { where.not(id: (Array.new(record.descendants) << record).flatten) }
end
