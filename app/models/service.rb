class Service < ActiveRecord::Base
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

  # Attachments for this service
  has_many :attachments, as: :parent, dependent: :destroy, autosave: true, class_name: "Shoppe::Attachment"
  # The product's categorizations
  #

  def attachments=(attrs)
    if attrs["default_image"]["file"].present? then self.attachments.build(attrs["default_image"]) end
  end
  # All active services
  scope :active, -> { where(active: true) }
  scope :featured, -> { where(featured: true) }
  validates :name, presence: true
  validates :permalink, presence: true, uniqueness: true, permalink: true
  # Before validation, set the permalink if we don't already have one
  before_validation { self.permalink = name.parameterize if permalink.blank? && name.is_a?(String) }
end
