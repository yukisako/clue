class EventsController < ApplicationController

  add_breadcrumb 'TOP', :root_path

  def index
    @events = Event.all
    add_breadcrumb '新着情報'
  end

  def show
    @event = Event.find(params[:id])
    @participants = Participant.where(event_id: params[:id])
    unless @participants.find_by(user_id: current_user.id, event_id: params[:id]).present?
      @participant = Participant.new
    else
      @participant = @participants.find_by(user_id: current_user.id, event_id: params[:id])
    end

    add_breadcrumb '新着情報', events_path
    add_breadcrumb @event.title
  end

  def new
    @event = Event.new
  end

  def create
    Event.create(submit_params)
    redirect_to action: :index
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    Event.find(params[:id]).update(submit_params)
    redirect_to action: :show
  end

  def destroy
    @event = Event.find(params[:id]).destroy
    redirect_to action: :index
  end

  private
  def submit_params
    params.require(:event).permit(:title, :content, :held_at, :price, :image)
  end
end
