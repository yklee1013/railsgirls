class SessionsController < ApplicationController
  protect_from_forgery with: :exception

  before_filter :logout_required, only: [:new]

  def new
  end

  def create
    @current_user = User.from_auth(auth)

    if auth['provider'] == 'identity' && !auth['info']['confirmed']
      return redirect_to root_path
    end

    return_to = session.delete(:return_to)
    reset_session
    session[:user_id] = @current_user.id

    if return_to
      redirect_to return_to
    else
      redirect_to root_path
    end
  end

  def destroy
    @current_user = nil
    reset_session
    redirect_to root_path
  end

  private

  def auth; request.env['omniauth.auth'] end
end
