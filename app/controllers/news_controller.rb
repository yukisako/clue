class NewsController < ApplicationController
  def index
    @news = NewInfo.all
  end

  def show
    @news = NewInfo.find(params[:id])
    @participants = Participant.where(event_id: params[:id])
    @participant = Participant.new
  end

  def new
    @news = NewInfo.new
  end

  def create
    NewInfo.create(submit_params)
    redirect_to action: :index
  end

  def edit
    @news = NewInfo.find(params[:id])
  end

  def update
    NewInfo.find(params[:id]).update(submit_params)
    redirect_to action: :show
  end

  def destroy
    @news = NewInfo.find(params[:id]).destroy
    redirect_to action: :index
  end

  private
  def submit_params
    params.require(:new_info).permit(:title, :content, :held_at, :price, :image)
  end
end
