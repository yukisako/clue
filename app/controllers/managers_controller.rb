class ManagersController < ApplicationController
  def index
  end

  def account
    @offers = Offer.where(status: 3).order(meet_at: :desc)
    @payments = Payment.all
    @sales = @offers.payed
    @payed = @payments.sum(:amount)
  end

  def report
    @reports = ReportedAccount
    @users = User.where('reported >= ?', 1).order(reported: :desc)
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
