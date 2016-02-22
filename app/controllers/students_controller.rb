class StudentsController < ApplicationController
  before_action :redirect_to_index, only: [:show]

  add_breadcrumb 'TOP', :root_path
  add_breadcrumb '生徒を探す', :search_students_path

  def index
    @students = User.where(user_type: 1, search_permit: 1)
                  .page(params[:page])
  end

  def search
    @students = User.where(user_type: 1, search_permit: 1)
                  .search_params("profile", params[:keyword])
                  .search_params("area", params[:area])
                  .search_params("sex", params[:sex])
                  .search_age(params[:min_age], params[:max_age])
                  .page(params[:page])
    @param_keyword = "プロフィールに「#{params[:keyword]}」を含む生徒" if params[:keyword].present?
    @param_min_age = "#{params[:min_age]}歳以上" if params[:min_age].present?
    @param_max_age = "#{params[:max_age]}歳以下" if params[:max_age].present?
    @param_area = "#{params[:area]}在住" if params[:area].present?
    @param_sex = param_sex

    render action: :index
  end

  def show
    @student = User.find(params[:id])
    add_breadcrumb '生徒情報'
  end

  private
  def param_sex
    if params[:sex] == "男" || params[:sex] == "女"
      "#{params[:sex]}性"
    end
  end
  
  def redirect_to_index
    if User.find(params[:id]).search_permit == 0
      redirect_to action: :index
    end
  end
end
