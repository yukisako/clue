class TopController < ApplicationController

  def index
    
    if user_signed_in?
      if current_user.user_type != 3
        @supporters = User.where(user_type: 3)
        render template: 'supporters/index'
      elsif current_user.user_type == 3
        @students = User.where(user_type: 1, search_permit: 1)
        render template: 'students/index'
      elsif current_user.user_type == 0
        render templete: 'managers/index'
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
