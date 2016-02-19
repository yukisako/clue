class Event < ActiveRecord::Base
  has_many :participants

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 65535 }
  validates :price, :numericality => {:only_integer => true}

  has_attached_file :image,
    styles: { medium: "600x200#" }

  validates_attachment :image,
    content_type: {
      content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    }
end
