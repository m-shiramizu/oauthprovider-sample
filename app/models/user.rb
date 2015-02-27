class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  validates :username, presence: true, uniqueness: true

  def self.from_omniauth(auth)

   user = User.find_by(uid: auth.uid, provider: auth.provider)

   unless user
      user = User.create(
                         provider: auth.provider,
                         username: auth.info.name,
                         uid: auth.uid,
                         email: auth.info.email
                         )
   end
   user
  end

  # Devise の RegistrationsController はリソースを生成する前に self.new_sith_session を呼ぶ
  # つまり、self.new_with_sessionを実装することで、サインアップ前のuserオブジェクトを初期化する
  # ときに session からデータをコピーすることができます。
  # OmniauthCallbacksControllerでsessionに値を設定したので、それをuserオブジェクトにコピーします。
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  # providerがある場合（Facebook経由で認証した）は、
  # passwordは要求しないようにする。
  def password_required?
    super && provider.blank?
  end

end

