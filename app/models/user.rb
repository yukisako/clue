class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :offers
  has_many :payments
  has_many :accounts, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :events, through: :participants
  has_many :reported_accounts, dependent: :destroy
  has_many :send_messages, class_name: 'Message', foreign_key: 'sender_id', dependent: :destroy
  has_many :receive_messages, class_name: 'Message', foreign_key: 'receiver_id', dependent: :destroy
  has_one :ticket, dependent: :destroy
  has_one :absence_trigger, dependent: :destroy

  accepts_nested_attributes_for :absence_trigger

  has_attached_file :avatar,
    styles: { medium: "300x300#", thumb: "100x100#" }

  validates_attachment :avatar,
    content_type: {
      content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    }

  def age
    if self.birth
      d1 = self.birth.strftime("%Y%m%d").to_i
      d2 = Date.today.strftime("%Y%m%d").to_i
      return (d2 - d1) / 10000
    end
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

  def self.search_trigger(trigger)
    if trigger.present?
      joins(:absence_trigger).where("#{trigger} = ?", true)
    else
      order(updated_at: :desc)
    end
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # DBのユーザーをauth情報から取得
    db_auth_user = User.find_by(uid: auth.uid, provider: auth.provider)

    # ユーザーを特定
    user = signed_in_resource ? signed_in_resource : db_auth_user

    if user.nil?
      email = auth.info.email
      # ユーザーを作成
      user = User.new(
        name: auth.extra.raw_info.name,
        first_name: auth.extra.raw_info.first_name,
        family_name: auth.extra.raw_info.last_name,
        email: email ? email : "change@me-#{auth.uid}-#{auth.provider}.com",
        password: Devise.friendly_token[0,20],
        uid: auth.uid,
        provider: auth.provider
      )
      user.skip_confirmation!
      user.save!
    end

    user
  end
end
