class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :offers
  has_one :absence_trigger, through: :user

  def self.search_params(key, params)
    if params.present?
      where("#{key} like ?", "%#{params}%")
    else
      order(updated_at: :desc)
    end
  end

  def age
    d1 = self.host_birth.strftime("%Y%m%d").to_i
    d2 = Date.today.strftime("%Y%m%d").to_i
    return (d2 - d1) / 10000
  end

  def self.search_age(min, max)
    min_age = Date.today << (min.to_i*12)
    max_age = Date.today << (max.to_i*12)
    if min.present? && max.present?
      where('host_birth <= ?', min_age).where('host_birth >= ?', max_age << 12)
    elsif min.present?
      where('host_birth <= ?', min_age)
    elsif max.present?
      where('host_birth >= ?', max_age << 12)
    else
      order(updated_at: :desc)
    end
  end
end
