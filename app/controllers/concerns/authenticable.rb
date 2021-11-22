module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate!
  end

  private
  def authenticate!
    redirect_to sessions_new_path if Current.user.nil?
  end
end
