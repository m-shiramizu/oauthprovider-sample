class Users::SessionsController < Devise::SessionsController
  # destroy はこれが呼ばれるのでスキップ
  skip_before_filter :verify_signed_out_user

  # ログインした時
  def new
    super
  end
  
  # ログインユーザーを作ったり
  def create
    super
  end

  # ログアウト
  def destroy 
    # 現ユーザーのトークンを取得
    tokens =  Doorkeeper::AccessToken.where(resource_owner_id: current_user.id, revoked_at: nil)

    #全トークンをrevokeする
    tokens.map {|item| item.update_attribute(:revoked_at, DateTime.now) }

    super
    reset_session
  end

end
