class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :handle_cookies

  def handle_cookies
    cookies[:pets] = [2, 6, 9]
  end
end
