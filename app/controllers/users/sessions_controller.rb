class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  add_breadcrumb 'ホーム', :root_path

  # GET /resource/sign_in
  def new
    add_breadcrumb 'ログイン', :new_user_session_path
    super
  end

  # POST /resource/sign_in
  def create
    if current_user && current_user.user_type == 0
      redirect_to managers_index_path
    else
      super
    end
    add_breadcrumb 'ログイン', :user_session_path
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
