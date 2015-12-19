class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :messages
  has_many :tickets
  has_many :diaries
  has_many :comments
  
  has_attached_file :avatar,
    styles: { medium: "300x300#", thumb: "100x100#" }

  validates_attachment :avatar,
    content_type: {
      content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    }

  def age
    d1 = self.birth.strftime("%Y%m%d").to_i
    d2 = Date.today.strftime("%Y%m%d").to_i
    return (d2 - d1) / 10000
  end

  def self.search_params(key, params)
    if params.present?
      where("#{key} like ?", "%#{params}%")
    else
      order(updated_at: :desc)
    end
  end
  
  def self.search_age(min, max)
    min_age = Date.today << (min.to_i*12)
    max_age = Date.today << (max.to_i*12)
    if min.present? && max.present?
      where('birth <= ?', min_age >> 12).where('birth >= ?', max_age << 12)
    elsif min.present?
      where('birth <= ?', min_age >> 12)
    elsif max.present?
      where('birth >= ?', max_age << 12)
    else
      order(updated_at: :desc)
    end
  end
end
