class Managers::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  add_breadcrumb '管理トップ', :managers_index_path

  def index
    add_breadcrumb 'ユーザー管理'
    @users = User.all
    @students = @users.where(user_type: 1)
    @parents = @users.where(user_type: 2)
    @supporters = @users.where(user_type: 3)
    @types = [@students, @parents, @supporters]
    @caption = ['生徒情報', '保護者情報', '先輩情報']
  end

  def show
    @user = User.find(params[:id])
    if @user.accounts.present?
      @accounts = @user.accounts
    end
    add_breadcrumb 'ユーザー管理', managers_users_path
    add_breadcrumb 'ユーザー詳細', managers_user_path(@user.id)
  end

  def edit
    @user = User.find(params[:id])
    @grade = grade_params
    @job = job_params
    add_breadcrumb 'ユーザー管理', managers_users_path
    add_breadcrumb 'ユーザー詳細', managers_user_path(@user.id)
    add_breadcrumb 'ユーザー編集'
  end

  def update
    @user = User.find(params[:id]).update(submit_params)
    redirect_to managers_user_path(params[:id])
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to managers_users_path
  end

  private
  def submit_params
    params.require(:user).permit(:email, :username, :avatar, :sex, :birth, :job, :grade, :post_number, :area, :address, :tel, :line_id, :profile, :search_permit, :permit_info_mail, :absent_span, :block, :reported, :family_name, :first_name, :family_name_kana, :first_name_kana).merge(name: "#{params[:user][:family_name]} #{params[:user][:first_name]}", name_kana: "#{params[:user][:family_name_kana]} #{params[:user][:first_name_kana]}")
  end
end
