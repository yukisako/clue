class Managers::MessagesController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  add_breadcrumb '管理トップ', :managers_index_path
  add_breadcrumb 'メッセージ管理', nil, :only => [:index, :search]

  def index
    @q = Message.search
  end

  def search
    @q = Message.search(search_params)
    @messages = @q.result
    render "shared/search"
  end

  def show
    add_breadcrumb 'メッセージ管理', :managers_messages_path
    add_breadcrumb 'メッセージ詳細'
    @message = Message.find(params[:id])
    @sender = @message.sender
    @receiver = @message.receiver
  end

  private

  def search_params
    search_conditions = %w(title_cont s)
    params.require(:q).permit(search_conditions)
  end
  
end
