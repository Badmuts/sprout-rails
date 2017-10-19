class UserTokenController < Knock::AuthTokenController
  wrap_parameters User, include: [:email, :password]

  private
    def auth_params
      params.require(:user).permit :email, :password
    end
end
