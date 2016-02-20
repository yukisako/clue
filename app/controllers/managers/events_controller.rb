class Managers::EventsController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  add_breadcrumb '管理トップ', :managers_index_path

  def index
    add_breadcrumb '新着情報管理'
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @participants = Participant.where(event_id: params[:id])
    unless @participants.find_by(user_id: current_user.id, event_id: params[:id]).present?
      @participant = Participant.new
    else
      @participant = @participants.find_by(user_id: current_user.id, event_id: params[:id])
    end
  end

  def new
    add_breadcrumb '新着情報投稿'
    @event = Event.new
  end

  def create
    @event = Event.create(submit_params)
    if @event.save
      redirect_to managers_events_url, notice: 'イベントを作成しました'
    else
      flash.now[:alert] = "必須情報の入力が必要です"
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
    add_breadcrumb '新着情報管理', managers_events_path
    add_breadcrumb '新着情報編集'
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(submit_params)
      redirect_to managers_events_url, notice: 'イベントを更新しました'
    else
      flash.now[:alert] = "必須情報の入力が必要です"
      render 'edit'
    end
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
