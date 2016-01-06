class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    @ticket = @user.ticket
    @accounts = @user.accounts
    @reputation = reputation_params
  end

  def edit
    @user = User.find(current_user.id)
    @user.absence_trigger = AbsenceTrigger.find_by(user_id: current_user.id)
    @area = area_params
    @job = job_params
    @grade = grade_params
  end

  def update
    if params[:commit] == 'キャンセル'
      redirect_to action: :show and return
    end
    @user = User.find(current_user.id).update(submit_params)
    @trigger = AbsenceTrigger.find_by(user_id: current_user.id)
    if params[:user][:absence_trigger].present?
      if @trigger.present?
        @trigger.update(permitted_trigger_params)
      else
        AbsenceTrigger.create(permitted_trigger_params)
      end
    end
    redirect_to action: :show
  end

  def register
    @user = User.find(current_user.id)
    @sex = sex_params
  end

  def confirm_register
    if full_registration_info
      @user = User.find(current_user.id)
      @user_type = user_type_confirmation
    else
      @user = User.find(current_user.id)
      @user.username = params[:user][:username]
      @user.birth = params[:user][:birth]
      @sex = sex_params
      render action: :register and return
    end
  end

  def add_info
    if params[:commit] == '戻る'
      # 前ページで「戻る」を選択した場合
      @user = User.find(current_user.id)
      @user.username = params[:user][:username]
      @user.birth = params[:user][:birth]
      @sex = sex_params
      render action: :register and return
    else
      # 正常な処理
      User.find(current_user.id).update(register_params)
      @user = current_user
      @user.absence_trigger = current_user.absence_trigger
      @area = area_params
      @grade = grade_params
      @job = job_params
    end
  end

  def update_add_info
    if complete_registration_info
      # 正常な処理
      User.find(current_user.id).update(name: "#{params[:user][:family_name]} #{params[:user][:first_name]}", name_kana: "#{params[:user][:family_name_kana]} #{params[:user][:first_name_kana]}", first_name: params[:user][:first_name], family_name: params[:user][:family_name], first_name_kana: params[:user][:first_name_kana], family_name_kana: params[:user][:family_name_kana], post_number: params[:user][:post_number], area: params[:user][:area], address: params[:user][:address], tel: params[:user][:tel], line_id: params[:user][:line_id], grade: params[:user][:grade], job: params[:user][:job], school: params[:user][:school], absent_span: params[:user][:absent_span], avatar: params[:user][:avatar])
      AbsenceTrigger.where(user_id: current_user.id).first_or_create(initial_trigger_params)
    else
      # 前ページで入力情報が不足していた場合
      @notice = '必須登録情報が入力されていません。'

      # セレクトボックス用パラメーター
      @area = area_params
      @grade = grade_params
      @job = job_params

      # 既に入力した情報を初期値として表示
      @user = current_user
      @user.family_name = params[:user][:family_name]
      @user.first_name = params[:user][:first_name]
      @user.family_name_kana = params[:user][:family_name_kana]
      @user.first_name_kana = params[:user][:first_name_kana]
      @user.post_number = params[:user][:post_number]
      @user.area = params[:user][:area]
      @user.address = params[:user][:address]
      @user.tel = params[:user][:tel]
      @user.line_id = params[:user][:line_id]
      @user.permit_info_mail = params[:user][:permit_info_mail]
      @user.grade = params[:user][:grade]
      @user.job = params[:user][:job]
      @user.school = params[:user][:school]
      @user.absent_span = params[:user][:absent_span]
      @user.profile = params[:user][:profile]
      @user.avatar = params[:user][:avatar]

      render action: :add_info and return
    end

    if current_user.user_type == 1
      redirect_to root_path
    else
      redirect_to new_ticket_path
    end
  end

  def account
    @account = Account.new
    @letters = initial_letter_params
    @kanas = initial_kana_params
    @notice = params[:notice]
    if params[:q].present?
      @store = BankDatum.find(params[:q])
      @bank_id = @store.bank_id
      @bank_name = @store.bank_name
      @store_id = @store.store_id
      @store_name = @store.store_name
      @account.account_id = params[:account_id]
      @account.user_name = params[:user_name]
      @id = params[:q]
    end
  end

  def search_bank
    @banks = Bank.where('name_kana like?', params[:q]+'%')
  end

  def select_bank
    @bank = Bank.find(params[:q])
    @letters = initial_letter_params
    @kanas = initial_kana_params
  end

  def search_store
    @stores = BankDatum.where(bank_id: bank_id_params(params[:bank_id])).where('store_name_kana like?', params[:q]+'%')
  end

  def select_store
    @store = BankDatum.find(params[:q])
  end

  def reset_account
    @letters = initial_letter_params
    @kanas = initial_kana_params
  end

  def confirm_account
    if params[:q].present? && params[:account][:account_id].present? && params[:account][:user_name].present?
      # 正常な処理
      @store = BankDatum.find(params[:q])
    elsif params[:q].present?
      # 口座番号もしくは名義の入力漏れ
      @store = BankDatum.find(params[:q])
      @account = Account.new
      @letters = initial_letter_params
      @kanas = initial_kana_params
      @bank_id = @store.bank_id
      @bank_name = @store.bank_name
      @store_id = @store.store_id
      @store_name = @store.store_name
      @id = @store.id
      @notice = '必要情報が入力されていません。'
      render action: :account and return
    else
      # 何も入力していない
      @account = Account.new
      @letters = initial_letter_params
      @kanas = initial_kana_params
      @notice = '必要情報が入力されていません。'
      render action: :account and return
    end
  end

  def report
    @reported_account = ReportedAccount.new
    @user = User.find(params[:user_id])
  end

  def reported
    # 通報された人の通報回数を1回加算
    @reported_account = User.find(params[:reported_account][:user_id])
    unless ReportedAccount.where(user_id: params[:reported_account][:user_id], reporter_id: current_user.id).present?
      if @reported_account.reported.present?
        count_report = @reported_account.reported + 1
      else
        count_report = 1
      end
      # 通報事例テーブルに事例を追加
      @reported_account.update(reported: count_report)
      ReportedAccount.where(reporter_id: current_user.id, user_id: params[:reported_account][:user_id]).first_or_create(report_params)
    end
    redirect_to supporters_path
  end

  private
  def submit_params
    params.require(:user).permit(:username, :avatar, :job, :post_number, :area, :address, :tel, :line_id, :profile, :search_permit, :permit_info_mail, :absent_span, :block, :reported, :family_name, :first_name, :family_name_kana, :first_name_kana, absence_triggers_attributes: [:classroom, :harm, :antipathy, :teacher, :friendship, :study, :change_school, :neglect, :dv, :poverty, :parents, :no_reason]).merge(name: "#{params[:user][:family_name]} #{params[:user][:first_name]}", name_kana: "#{params[:user][:family_name_kana]} #{params[:user][:first_name_kana]}")
  end

  def register_params
    params.require(:user).permit(:username, :user_type, :birth, :sex)
  end

  def initial_trigger_params
    params.require(:absence_trigger).permit(:classroom, :harm, :antipathy, :teacher, :friendship, :study, :change_school, :neglect, :dv, :poverty, :parents, :no_reason).merge(user_id: current_user.id)
  end

  def permitted_trigger_params
    params.require(:user).require(:absence_triggers).permit(:classroom, :harm, :antipathy, :teacher, :friendship, :study, :change_school, :neglect, :dv, :poverty, :parents, :no_reason).merge(user_id: current_user.id)
  end

  def report_params
    params.require(:reported_account).permit(:reason).merge(reporter_id: current_user.id, user_id: params[:reported_account][:user_id])
  end

  def user_type_confirmation
    if params[:user][:user_type].to_i == 1
      return '生徒'
    elsif params[:user][:user_type].to_i == 2
      return '保護者'
    elsif params[:user][:user_type].to_i == 3
      return '不登校経験者'
    end
  end

  def full_registration_info
    params[:user][:username].present? && params[:user][:birth].present?
  end

  def complete_registration_info
    params[:user][:family_name].present? && params[:user][:first_name].present? && params[:user][:family_name_kana].present? && params[:user][:first_name_kana].present? && params[:user][:area].present? && params[:user][:grade].present? && params[:user][:absent_span].present?
  end

  def reputation_params
    reputation = 0
    if @reviews.present?
      @reviews.each do |rev|
        reputation = reputation + rev.reputation
      end
      return reputation / @reviews.count
    else
      return 0
    end
  end
end
