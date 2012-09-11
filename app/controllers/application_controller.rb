class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :establish_controller_action

  protected
    def establish_controller_action
      @controller = params[:controller]
      @action = params[:action]
    end
end
