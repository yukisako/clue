class TicketsController < ApplicationController
  before_action :authenticate_user!, :full_profile

  def new
    @price = price_params
    @hour = hour_params
    @area = area_params
    unless Ticket.find_by(user_id: current_user.id).present?
      @ticket = Ticket.new
      @ticket.area = current_user.area
    else
      @ticket = Ticket.find_by(user_id: current_user.id)
      render action: :edit and return
    end
  end

  def create
    Ticket.create(submit_params)
    redirect_to root_path
  end

  def edit
    @area = area_params
    @hour = hour_params
    @price = price_params
    if Ticket.find_by(user_id: current_user.id).present?
      @ticket = Ticket.find_by(user_id: current_user.id)
    else
      @ticket = Ticket.new
      render action: :new and return
    end
  end

  def update
    @ticket = Ticket.find(params[:id]).update(submit_params)
    redirect_to action: :show
  end

  def purchase
  end

  private
  def submit_params
    params.require(:ticket).permit(:user_id, :title, :price, :length, :rate, :area, :place, :message)
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
