class MessagesController < ApplicationController
  before_action :authenticate_user!, :full_profile
  before_action :redirect_to_index, only: :show

  add_breadcrumb 'TOP', :root_path

  def index
    @messages = Message.order(updated_at: :desc).includes(:sender, :receiver)
    @inbox = @messages.where(receiver_id: current_user.id, sent: 1)
    @outbox = @messages.where(sender_id: current_user.id)
    
    add_breadcrumb 'メッセージボックス', messages_path
  end

  def show
    @message = Message.find(params[:id])
    @sender = @message.sender
    @receiver = @message.receiver
    @offer = @message.offer
    @ticket = @offer.ticket if @offer
    @user = @ticket.user  if @ticket
    @status = ['調整中','確定待ち','確定済み']
    @messages = show_past_messages
    # 既読つける
    if @message.receiver_id == current_user.id
      @message.update(opened: 1)
    end
    add_breadcrumb 'メッセージボックス', messages_path
    add_breadcrumb 'メッセージ'
  end

  def new
    @message = Message.new
    @receiver = User.find(params[:receiver_id])
    @messages = new_past_messages
    
    add_breadcrumb 'メッセージボックス', messages_path
    add_breadcrumb '新規作成'
  end

  def create
    @message = Message.create(submit_params)
    redirect_to action: :index
  end

  def destroy
    @message = Message.find(params[:id]).destroy
    redirect_to action: :index
  end

  private
  def submit_params
    params.require('message').permit(:sender_id, :receiver_id, :title, :message, :sent, :offer_id)
  end

  def new_past_messages
    Message.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id).where("receiver_id = ? or sender_id = ?", params[:receiver_id], params[:receiver_id]).order(id: :desc)
  end

  def show_past_messages
    messages = Message.all
    if @message.receiver_id == current_user.id
      messages.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id).where("receiver_id = ? or sender_id = ?", messages.find(params[:id]).sender_id, messages.find(params[:id]).sender_id).order(id: :desc)
    else
      messages.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id).where("receiver_id = ? or sender_id = ?", messages.find(params[:id]).receiver_id, messages.find(params[:id]).receiver_id).order(id: :desc)
    end
  end

  def redirect_to_index
    @message = Message.find(params[:id])
    unless current_user.id == @message.sender_id || current_user.id == @message.receiver_id
      redirect_to action: :index
    end
  end
end