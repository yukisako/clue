class TopController < ApplicationController

  add_breadcrumb 'TOP', :root_path

  def index
    if user_signed_in?
      if current_user.user_type == 0
        redirect_to managers_index_path
      elsif current_user.user_type != 3
        add_breadcrumb '先輩を探す', :supporters_path
        @supporters = User.where(user_type: 3).page(params[:page])
        render template: 'supporters/index'
      elsif current_user.user_type == 3
        add_breadcrumb '生徒を探す', :students_path
        @students = User.where(user_type: 1, search_permit: 1).page(params[:page])
        render template: 'students/index'
      end
    end
  end

  def parent
  end

  def student_user
  end

  def supporter
    @user = User.new
  end

  def about
  end

  def corporate
  end

  def privacy
  end

  def terms
  end

  def legal
  end

  def contact
  end
end
