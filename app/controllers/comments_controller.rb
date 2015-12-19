class CommentsController < ApplicationController
  def create
    Comment.create(submit_params)
    redirect_to :back
  end

  def update
    Comment.find(params[:id]).update(submit_params)
    redirect_to :back
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back
  end

  private
  def submit_params
    params.require('comment').permit(:user_id, :diary_id, :comment)
  end
end
