class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  Role.all.each do |r|
    define_method "verify_#{r.name}" do
      unless current_user.present? && current_user.has_role?(r.name)
        @role = r
        render :missing_role
      end
    end

    define_method "admin_or_role" do |req, **opts|
      opts[:scope] ||= nil
      unless current_user.present? && (current_user.has_role?(:admin) || current_user.has_role?(req, opts[:scope]))
        @role = r
        render :missing_role
      end
    end
  end
end
