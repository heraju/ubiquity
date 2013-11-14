class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    puts request.env['omniauth.auth']
    puts '-'*100
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      if (devise_mapping.confirmable? && controller_name != 'confirmations' && !@user.confirmed?)
        redirect_to new_user_session_url, notice: 'A message with a confirmation link has been sent to your email address. Please open the link to activate your account.'
      else
        sign_in_and_redirect @user, :event => :authentication
        #redirect_to root_url # TODO find condition - Don't know when this condition will occur
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end

