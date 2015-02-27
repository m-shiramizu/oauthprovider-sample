class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # deviceのコントローラーのときに、下記のメソッドを呼ぶ
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインイン後の飛び先
  def after_sign_in_path_for(resource)
     ENV['DOORKEEPER_TOPSITE_URI']
  end
  
  # サインアウト後の飛び先
  def after_sign_out_path_for(resource)
    # サインイン画面
    redirect_uri = ENV['DOORKEEPER_AUTHPROVIDER_URI'] + 'users/sign_in'
  end
  

  # 認可コード・ユーザーIDを付与してリダイレクト
  def doorkeeper_ret_code_and_id(auth)
    auth = authorization.authorize
    code = auth.redirect_uri[:code]
    # リダイレクト元
    redirect_uri = auth.pre_auth.redirect_uri
    redirect_to = redirect_uri
  end

  protected
    def configure_permitted_parameters
      # sign_inのときに、emailも許可する
      devise_parameter_sanitizer.for(:sign_in) << :email
      # sign_upのときに、emailも許可する
      devise_parameter_sanitizer.for(:sign_up) << :email
      #  account_updateのときに、emailも許可する
      devise_parameter_sanitizer.for(:account_update) << :email
    end
end
