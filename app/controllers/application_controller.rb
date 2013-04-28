class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_locale

  helper_method :current_user, :logged_in?

  def store_location
    session[:return_to] = request.original_url
  end

  def unauthorized!(admin = false)
    session[:return_to] = url_for(params) if !request.xhr?
    redirect_to login_path
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.try(:id)
  end

  def logged_in?
    !!current_user
  end

  def admin_required
    redirect_to root_path unless current_user and current_user.admin?
  end

  def login_required
    unauthorized! unless logged_in?
  end

  def logout_required
    redirect_to root_path if logged_in?
  end

  private

  def extract_locale_from_accept_language_header
    v = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    v == 'zh' ? 'zh-CN' : v
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header
  end
end
