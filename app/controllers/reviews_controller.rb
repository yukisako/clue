class ReviewsController < ApplicationController
  def create
    Review.create(submit_params)
    redirect_to :back
  end

  def update
    Review.find(params[:id]).update(submit_params)
    redirect_to :back
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to :back
  end

  private
  def submit_params
    params.require('review').permit(:user_id, :ticket_id, :reputation, :review)
  end
end
