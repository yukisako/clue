class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_common_data

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << [:name, :name_kana, :family_name, :first_name, :family_name_kana, :first_name_kana, :area, :sex, :birth, :user_type, :job]
    devise_parameter_sanitizer.for(:sign_up) << [:name, :name_kana, :family_name, :first_name, :family_name_kana, :first_name_kana, :area, :sex, :birth, :user_type, :job]
    devise_parameter_sanitizer.for(:account_update) << [:name, :name_kana, :family_name, :first_name, :family_name_kana, :first_name_kana, :area, :sex, :birth, :user_type, :job]
  end
  
  def sex_params
    sex_params = [
      '男性', '女性', 'その他']
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
  
  def grade_params
    grade_params = [
        '小学校低学年','小学4年生','小学5年生','小学6年生','中学1年生','中学2年生','中学3年生','高校生'
      ]
  end

  def trigger_params
    trigger_params = {
      "学級崩壊" => "classroom", "いじめ" => "harm", "学校への苦手意識" => "antipathy", "先生との関係" => "teacher", "友人関係" => "friendship", "勉強" => "study", "転校・転勤" => "change_school", "育児放棄" => "neglect", "家庭内暴力" => "dv", "経済的理由" => "poverty", "離婚などの親同士の関係" => "parents", "なんとなく" => "no_reason"
    }
  end

  def hour_params
    hour_params = [1, 1.5, 2, 2.5, 3, 3.5]
  end

  def price_params
    price_params = [2000, 3000, 4000, 5000, 6000, 7000, 8000, 9000, 10000]
  end
  
  def user_type_params
    user_type_params = [['生徒', 1], ['保護者', 2], ['経験者', 3]]    
  end


  def true_triggers(absence_trigger)
    true_triggers = []
    if absence_trigger.classroom == true
        true_triggers << '学級崩壊'
    end
    if absence_trigger.harm == true
        true_triggers << 'いじめ'
    end
    if absence_trigger.antipathy == true
        true_triggers << '学校への苦手意識'
    end
    if absence_trigger.teacher == true
        true_triggers << '先生との関係'
    end
    if absence_trigger.friendship == true
        true_triggers << '友人関係'
    end
    if absence_trigger.study == true
        true_triggers << '勉強'
    end
    if absence_trigger.change_school == true
        true_triggers << '転校・転勤'
    end
    if absence_trigger.neglect == true
        true_triggers << '育児放棄'
    end
    if absence_trigger.dv == true
        true_triggers << '家庭内暴力'
    end
    if absence_trigger.poverty == true
        true_triggers << '経済的理由'
    end
    if absence_trigger.parents == true
        true_triggers << '離婚など親同士の関係'
    end
    if absence_trigger.no_reason == true
        true_triggers << 'なんとなく'
    end
    return true_triggers
  end

  def category_params
    category_params = [
      "日記", "経験談", "悩み・困ったこと", "その他"
    ]
  end

  def bank_params
    bank_names = []
    bank_name = []
    bank_id = []
    Bank.all.each do |bank|
      bank_name << bank.name
      bank_id << bank.bank_id
    end
    return bank_names = [bank_name, bank_id]
  end

  def initial_letter_params
    initial_letter_params = [
      ["あ","い","う","え","お"],
      ["か","き","く","け","こ"],
      ["さ","し","す","せ","そ"],
      ["た","ち","つ","て","と"],
      ["な","に","ぬ","ね","の"],
      ["は","ひ","ふ","へ","ほ"],
      ["ま","み","む","め","も"],
      ["や","ゆ","よ"],
      ["ら","り","る","れ","ろ"],
      ["わ","を"]]
  end

  def initial_kana_params
    initial_kana_params = [
      ['ｱ','ｲ','ｳ','ｴ','ｵ'],
      ['ｶ','ｷ','ｸ','ｹ','ｺ'],
      ['ｻ','ｼ','ｽ','ｾ','ｿ'],
      ['ﾀ','ﾁ','ﾂ','ﾃ','ﾄ'],
      ['ﾅ','ﾆ','ﾇ','ﾈ','ﾉ'],
      ['ﾊ','ﾋ','ﾌ','ﾍ','ﾎ'],
      ['ﾏ','ﾐ','ﾑ','ﾒ','ﾓ'],
      ['ﾔ','ﾕ','ﾖ'],
      ['ﾗ','ﾘ','ﾙ','ﾚ','ﾛ'],
      ['ﾜ','ｦ']]
  end

  def bank_id_params(id)
    if id.to_i < 10
      bank_id = "000"+id.to_i.to_s
    elsif id.to_i < 100
      bank_id = "00"+id.to_i.to_s
    elsif id.to_i < 1000
      bank_id = "0"+id.to_i.to_s
    else
      bank_id = id.to_s
    end
  end

  def sales_params(offers)
    sum = 0
    offers.each do |offer|
      sum = sum + offer.price * (1 - offer.ticket.rate) / 100
    end
    return sum
  end

  def full_profile
    unless current_user.user_type?
      redirect_to register_users_path(current_user.id)
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.user_type?
      root_path
    else
      register_users_path(current_user.id)
    end
  end
  
  def set_common_data
    # ヘッダーメニューの検索で必要な情報をここでセットする
    @area = area_params
    @param_sex = sex_params
    @absence_triggers = trigger_params
  end

  def set_user_type_params
    @user_type_params = user_type_params
  end

end
