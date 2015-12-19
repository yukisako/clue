class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
    @area = area_params
    @job = job_params
  end

  def update
    @user = User.find(current_user.id).update(submit_params)
    redirect_to action: :show
  end

  private
  def submit_params
    params.require('user').permit(:avatar, :job, :area, :address, :tel, :line_id, :profile, :search_permit, :about, :price, :family_name, :first_name, :family_name_kana, :first_name_kana).merge(name: "#{params[:user][:family_name]} #{params[:user][:first_name]}", name_kana: "#{params[:user][:family_name_kana]} #{params[:user][:first_name_kana]}")
  end
end
