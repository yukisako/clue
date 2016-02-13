require 'spike_pay'
class OffersController < ApplicationController
  before_action :authenticate_user!, :full_profile

  def index
    if current_user.user_type != 3
      # 生徒もしくは保護者
      @offers = Offer.where(user_id: current_user.id).order(updated_at: :desc)
      @offers_name = ['確定待ち', '調整中', '申込履歴']
      @status_message = [
        'あなたが申込を確定すれば購入が成立する状態です。',
        '先輩の承認待ちです。メッセージをやりとりして調整を進めましょう。',
        '過去に販売したチケットです。']
    else
      # 先輩
      @offers = current_user.ticket.offers
      @offers_name = ['確定待ち', '調整中', '販売履歴']
      @status_message = [
        '申込者の承認待ちです。',
        'あなたが承認すれば、申込者に確定依頼を出します。タイトルをクリックすると申込内容を調整することもできます。メッセージをやりとりして調整を進めてください。',
        '過去に購入したチケットです。']
    end
    @pending_host = @offers.where(status: 1)
    @pending_user = @offers.where(status: 2)
    @past_offers = @offers.where(status: 3)
    @offers_list = [@pending_user, @pending_host, @past_offers]
  end

  def show
    @offer = Offer.find(params[:id])
    @ticket = @offer.ticket
    @hour = hour_params
    @price = price_params
    if current_user.user_type != 3
      @offer.update(updated: 0)
    end
  end

  def new
    @offer = Offer.new
    @ticket = Ticket.find(params[:ticket_id])
    @user = @ticket.user
  end

  def create

    spike = SpikePay.new('sk_test_JeypnVxWDIbQWVbLh54oN57R')

    #TODO: title?,description?

    param = {
       currency: 'JPY',
       amount: submit_params[:price],
       card: params[:card_token],
       products: [{
           id: '00001',
           title: 'item',
           description: 'item description',
           language: 'JA',
           price: submit_params[:price],
           currency: 'JPY',
           count: 1,
           stock: 1
       }]
    }

    # Charge
    @response = spike.charge.create(param)
    
    # @response attributes:
    # id: 20160122-100745-qs7oc6
    # object: charge
    # created: 1453457265
    # livemode: false
    # paid: true
    # amount: 2000
    # currency: JPY
    # refunded: false
    # card: {}
    # source: {}
    # captured: true
    # refunds: []
    # metadata: {}
    # please check
    # https://spike.cc/dashboard/developer/docs/api_reference
    # for more info.
    
    if @response.paid == true
      @offer = Offer.create(submit_params)
      @offer.message = Message.create(message_params)
    end
    redirect_to action: :index
    
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    # ステータスを変更
    if params[:commit] == '条件を承認'
      @offer.update(status: 2)
      redirect_to action: :index and return
    elsif params[:commit] == '申込を確定'
      @offer.update(status: 3)
      redirect_to action: :index and return
    elsif params[:commit] == '再調整依頼'
      @offer.update(status: 1)
      redirect_to action: :index and return
    elsif params[:commit] == '申込を削除' || params[:commit] == '申込を断る'
      @offer.destroy
      redirect_to action: :index and return
    end

    # 変更未読フラグを立てる
    if current_user.user_type == 3
      @offer.update(updated: 1)
    end

    @offer.update(submit_params)
    redirect_to action: :index
  end

  def destroy
    Offer.find(params[:id]).destroy
    redirect_to action: :index
  end

  private
  def submit_params
    params.require(:offer).permit(:ticket_id, :user_id, :meet_at, :length, :price, :area, :place, :message, :rate, :status, :card_token)
  end

  def message_params
    params.require(:offer).permit(:message).merge(sender_id: current_user.id, receiver_id: @offer.ticket.user_id, offer_id: @offer.id, sent: 1, title: "チケット購入の申込み")
  end
end
