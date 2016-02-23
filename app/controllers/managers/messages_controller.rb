class Managers::MessagesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  add_breadcrumb '管理トップ', :managers_index_path

  def index
    add_breadcrumb 'メッセージ管理'
    @messages = Message.order(updated_at: :desc).page(params[:page]).per(20)
  end

  def show
    add_breadcrumb 'メッセージ管理', :managers_messages_path
    add_breadcrumb 'メッセージ詳細'
    @message = Message.find(params[:id])
    @sender = @message.sender
    @receiver = @message.receiver
  end
end
