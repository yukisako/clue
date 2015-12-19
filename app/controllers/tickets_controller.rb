class TicketsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tickets = Ticket.order(updated_at: :desc).includes(:user)
  end

  def search
    @tickets = Ticket.where(user_id: params[:user_id])
    render :index
  end

  def show
    @ticket = Ticket.find(params[:id])
    @seller = User.find(@ticket.user_id)
  end

  def new
    @ticket = Ticket.new
    @area = area_params
  end

  def create
    @ticket = Ticket.create(submit_params)
    redirect_to action: :index
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @area = area_params
  end

  def update
    @ticket = Ticket.find(params[:id]).update(submit_params)
    redirect_to action: :show
  end

  def destroy
    Ticket.find(params[:id]).destroy
    redirect_to action: :index
  end

    def parchase
    end

  private
  def submit_params
    params.require('ticket').permit(:user_id, :title, :price, :length, :rate, :area, :place, :message)
  end
end
