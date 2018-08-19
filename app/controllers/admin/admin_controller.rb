module Admin
  class AdminController < ApplicationController
    layout "layouts/admin"
    before_action :verify_admin

    def index; end

    private

    def verify_admin
      return if current_user.admin?
      flash[:danger] = t ".not_admin"
      redirect_to root_url
    end
  end
end
