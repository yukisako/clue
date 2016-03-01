class ManagersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!

  add_breadcrumb '管理トップ', :managers_index_path

  def index
  end

  def account
    add_breadcrumb '収支管理'

    @offers = Offer.where(status: 3).order(meet_at: :desc)
    @payments = Payment.all
    @sales = @offers.payed
    @payed = @payments.sum(:amount)
  end

  def report
  end

  private
  def account_params
    account_params = []
    ids = []
    @reports.select(:user_id).uniq.each do |report|
      ids << {id: report.user_id, count: @reports.where(user_id: report.user_id).count}
    end
    ids = ids.sort_by{|id| id[:count]}
    ids.each do |id|
      account_params << id[:id]
    end
    return account_params
  end
end
