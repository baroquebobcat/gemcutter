class ApplicationController < ActionController::Base

  include Clearance::Authentication
  helper :all
  protect_from_forgery :only => [:create, :update, :destroy]
  layout 'application'

  def authenticate_with_api_key
    api_key = request.headers["Authorization"] || params[:api_key]
    self.current_user = User.find_by_api_key(api_key)
  end

  def verify_authenticated_user
    if current_user.nil?
      render :text => "Access Denied. Please sign up for an account at http://gemcutter.org", :status => 401
    elsif !current_user.email_confirmed
      render :text => "Access Denied. Please confirm your Gemcutter account.", :status => 403
    end
  end

  def find_gem
    @rubygem = Rubygem.find_by_name(params[:id])
    if @rubygem.blank?
      respond_to do |format|
        format.html do
          render :file => 'public/404.html'
        end
        format.json do
          render :text => "This rubygem could not be found.", :status => :not_found
        end
      end
    end
  end
end

# Make the namespaced controllers happy.
module Api; end
module Api::V1; end

class Clearance::SessionsController < ApplicationController

  include RubyforgeTransfer

  before_filter :rf_check, :only => :create

  private
  def url_after_create
    dashboard_url
  end
end
