class TicketsController < ApplicationController
  before_action :authenticate_user!, :full_profile
  
 add_breadcrumb 'TOP', :root_path
 add_breadcrumb 'マイページ', :user_path

  def new
    @price = price_params
    @hour = hour_params
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
  
   def show
    @ticket = Ticket.find(params[:id])
    add_breadcrumb 'チケット情報', :ticket_path
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
  add_breadcrumb '編集', :edit_ticket_path
end

 
  