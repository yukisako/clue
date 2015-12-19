class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = Message.order(created_at: :desc)
    @inbox = @messages.where(receiver_id: current_user.id, sent: 1)
    @outbox = @messages.where(sender_id: current_user.id)
    @user = User.all
  end

  def show
    @message = Message.find(params[:id])
    @users = User.all
    @sender = @users.find(@message.sender_id)
    @receiver = @users.find(@message.receiver_id)
    @opened = @message.update(opened: 1)
    @name = name(@sender.name, @sender.id)
    @messages = show_past_messages
  end

  def new
    @message = Message.new
    @receiver = User.find(params[:receiver_id])
    @messages = new_past_messages
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
    params.require('message').permit(:sender_id, :receiver_id, :title, :message, :sent)
  end
  
  def name(nm, id)
    if nm.present?
      name = nm
    else
      name = "ID: #{id}"
    end
  end
  
  def new_past_messages
    Message.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id).where("receiver_id = ? or sender_id = ?", params[:receiver_id], params[:receiver_id]).order(id: :desc)
  end

  def show_past_messages
    messages = Message.all
    if messages.find(params[:id]).receiver_id == current_user.id
      messages.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id).where("receiver_id = ? or sender_id = ?", messages.find(params[:id]).sender_id, messages.find(params[:id]).sender_id).order(id: :desc)
    else
      messages.where("receiver_id = ? or sender_id = ?", current_user.id, current_user.id).where("receiver_id = ? or sender_id = ?", messages.find(params[:id]).receiver_id, messages.find(params[:id]).receiver_id).order(id: :desc)
    end
  end
end