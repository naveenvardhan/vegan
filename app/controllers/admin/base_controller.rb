class Admin::BaseController < ApplicationController
  layout 'admin'

  # before_action :authenticate_user!
  # before_action :authorize_user!

  private

  def authorize_user!
    redirect_to root_path, alert: "Access Denied" unless current_user.present?
  end

  # def authorize_user!
  #   unless current_admin.superadmin?
  #     redirect_to root_path, alert: "Access Restricted"
  #   end
  # end
end
