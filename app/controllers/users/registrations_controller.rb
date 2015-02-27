class Users::RegistrationsController < Devise::RegistrationsController
 
  def new
    super
  end
 
  def create
    super
  end

  # ユーザー登録完了後
  def after_sign_up_path_for(resource)
    # TOP画面
    ENV['DOORKEEPER_TOPSITE_URI']
  end

  def after_inactive_sign_up_path_for(resource)
    # TOP画面
    ENV['DOORKEEPER_TOPSITE_URI']
  end

end
