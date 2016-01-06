class DiariesController < ApplicationController
  before_action :authenticate_user!, :full_profile

  def index
    @diaries = Diary.order(updated_at: :desc).includes(:user)
    @comments = Comment.all
    @categories = category_params
  end

  def search
    @diaries = Diary.search_params("category", params[:category]).search_params("user_id", params[:user_id]).order(updated_at: :desc).includes(:user)
    @comments = Comment.all
    @categories = category_params
    render action: :index
  end

  def show
    @diary = Diary.find(params[:id])
    @author = User.find(@diary.user_id)
    @comments = Comment.where(diary_id: params[:id]).includes(:user)
    @comment = Comment.new
  end

  def new
    @diary = Diary.new
    @categories = category_params
  end

  def create
    @diary = Diary.create(submit_params)
    redirect_to action: :index
  end

  def edit
    @diary = Diary.find(params[:id])
    @categories = category_params
  end

  def update
    @diary = Diary.find(params[:id]).update(submit_params)
    redirect_to action: :show
  end

  def destroy
    @diary = Diary.find(params[:id]).destroy
    redirect_to action: :index
  end

  private
  def submit_params
    params.require('diary').permit(:category, :title, :content, :user_id, :premit)
  end
end