# frozen_string_literal: true

class Omni::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    callback_for_all_providers
  end

  def callback_for_all_providers
    unless request.env["omniauth.auth"].present?
      flash[:danger] = "Authentication data was not recieved, please try again."
      redirect_to root_url and return
    end

    provider = __callee__.to_s
    user = ::OAuthService::GetOAuthUser.call(request.env["omniauth.auth"])
    p user.inspect

    # TODO: Add email verification
    if user.persisted?
    # if user.persisted? && user.email_verified?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      user.reset_confirmation!
      flash[:warning] = "You need to confirm your email address to continue"
      redirect_to finish_signup_user_path(user)
    end
  end
end

# class Auth::OmniauthCallbacksController < Devise::OmniauthCallbacksController
#   # You should configure your model like this:
#   # devise :omniauthable, omniauth_providers: [:twitter]

#   # You should also create an action method in this controller like this:
#   # def twitter
#   # end

#   # More info at:
#   # https://github.com/heartcombo/devise#omniauth

#   # GET|POST /resource/auth/twitter
#   # def passthru
#   #   super
#   # end

#   # GET|POST /users/auth/twitter/callback
#   # def failure
#   #   super
#   # end

#   # protected

#   # The path used when OmniAuth fails
#   # def after_omniauth_failure_path_for(scope)
#   #   super(scope)
#   # end
# end
