class AccountsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @store = BankDatum.find(params[:q])
    Account.create(bank_id: @store.bank_id, bank_name: @store.bank_name, store_id: @store.store_id, store_name: @store.store_name, account_id: params[:account_id], user_name: params[:user_name], user_id: current_user.id)
    redirect_to user_path(current_user.id)
  end

  def edit
  end

  def update
    Account.find(params[:id]).update(submit_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    Account.find(params[:id]).destroy
    redirect_to user_path(current_user.id)
  end

  private
  def submit_params
    params.require(:account).permit(:user_id, :store_id, :store_name, :bank_name, :account_id, :user_name).merge(bank_id: bank_id)
  end
end
