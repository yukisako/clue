class SupportersController < ApplicationController
  def index
    @supporters = User.where(user_type: 3).includes(:ticket)
  end
  
  def search
    @supporters = User.where(user_type: 3).search_params("profile", params[:keyword]).search_params("area", params[:area]).search_params("sex", params[:sex]).search_trigger(params[:absence_trigger]).search_age(params[:min_age], params[:max_age])
    @param_keyword = "プロフィールに「#{params[:keyword]}」を含む先輩" if params[:keyword].present?
    @param_min_age = "#{params[:min_age]}歳以上" if params[:min_age].present?
    @param_max_age = "#{params[:max_age]}歳以下" if params[:max_age].present?
    @param_area = "#{params[:area]}在住" if params[:area].present?
    @param_sex = param_sex
    render action: :index
  end

  def show
    @supporter = User.find(params[:id])
    @ticket = @supporter.ticket
    @review = Review.new
    @reviews = Review.where(ticket_id: @ticket.id).order(created_at: :desc).includes(:user)
    @reputation = reputation_params
    @trigger = @supporter.absence_trigger
    @triggers = true_triggers(@trigger) if @trigger.present?
    if user_signed_in?
      @report = ReportedAccount.find_by(user_id: params[:id], reporter_id: current_user.id).present?
    end
  end

  private
  def param_sex
    if params[:sex] == "男" || params[:sex] == "女"
      "#{params[:sex]}性"
    end
  end

  def reputation_params
    reputation = 0
    if @reviews.present?
      @reviews.each do |rev|
        reputation = reputation + rev.reputation
      end
      return reputation / @reviews.count
    else
      return 0
    end
  end
end
