class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << [:name, :name_kana, :family_name, :first_name, :family_name_kana, :first_name_kana, :area, :sex, :birth, :user_type, :job]
    devise_parameter_sanitizer.for(:sign_up) << [:name, :name_kana, :family_name, :first_name, :family_name_kana, :first_name_kana, :area, :sex, :birth, :user_type, :job]
    devise_parameter_sanitizer.for(:account_update) << [:name, :name_kana, :family_name, :first_name, :family_name_kana, :first_name_kana, :area, :sex, :birth, :user_type, :job]
  end

  def area_params
    area_params = [
    '北海道', '青森県', '岩手県', '宮城県', '秋田県',
    '山形県', '福島県', '茨城県', '栃木県', '群馬県',
    '埼玉県', '千葉県', '東京都', '神奈川県', '新潟県',
    '富山県', '石川県', '福井県', '山梨県', '長野県',
    '岐阜県', '静岡県', '愛知県', '三重県', '滋賀県',
    '京都府', '大阪府', '兵庫県', '奈良県', '和歌山県',
    '鳥取県', '島根県', '岡山県', '広島県', '山口県',
    '徳島県', '香川県', '愛媛県', '高知県', '福岡県',
    '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県',
    '鹿児島県', '沖縄県']
  end
  
  def job_params
    job_params = [
      '会社員', '公務員', '自営業', '経営者', 'アルバイト', '学生', '無職'
    ]
  end

  def category_params
    category_params = [
      "日記", "経験談", "悩み・困ったこと", "その他"
    ]
  end
end
