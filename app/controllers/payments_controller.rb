class PaymentsController < ApplicationController
  def index
    @payments = Payment.where(user_id: current_user.id)
    @payed = @payments.sum(:amount) + 500 * (@payments.count)
    @offers = current_user.ticket.offers
    @payed_offers = @offers.where(status: 3).payed
    @sales = sales_params(@payed_offers)
    @balance = @sales - @payed
  end

  def new
    if current_user.accounts.present?
      # 正常な処理
      @payment = Payment.new
      @payments = Payment.where(user_id: current_user.id)
      @accounts = current_user.accounts
      @offers = current_user.ticket.offers.where(status: 3).payed
      @sales = sales_params(@offers)
      @balance = @sales - @payments.sum(:amount) - 500 * (@payments.count + 1)
      if @balance < 0
        @balance = 0
      end
    else
      # 振込口座が未登録の場合は登録画面に遷移
      redirect_to account_users_path(notice: '売上を出金するには振込口座を登録する必要があります。')
    end
  end

  def create
    if params[:payment][:amount].present?
      @account = Account.find(params[:account_id])
      Payment.create(submit_params)
      redirect_to action: :index
    else
      # 出金額が入力されていなかった場合の処理
      @payment = Payment.new
      @payments = Payment.where(user_id: current_user.id)
      @accounts = current_user.accounts
      @offers = current_user.ticket.offers.where(status: 3).payed
      @sales = @offers.sum(:price) * (100 - current_user.ticket.rate) / 100
      @balance = @sales - @payments.sum(:amount) - 500 * (@payments.count + 1)
      @notice = '出金額が入力されていません。'
      render action: :new and return
    end
  end

  private
  def submit_params
    params.require(:payment).permit(:user_id, :amount).merge(account_id: @account.account_id, bank_name: @account.bank_name, store_name: @account.store_name, user_name: @account.user_name)
  end

  def sales_params(offers)
    sales = 0
    offers.each do |offer|
      sales = sales + offer.price * (100 - offer.rate) / 100
    end
    return sales
  end
end
