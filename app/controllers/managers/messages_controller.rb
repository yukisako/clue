class Managers::MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = Message.order(updated_at: :desc)
    @count = @messages.count
  end

  def show
    @message = Message.find(params[:id])
    @sender = @message.sender
    @receiver = @message.receiver
  end
end
