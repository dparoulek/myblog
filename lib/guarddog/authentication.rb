module GuardDog
  module Authentication

    # This mixes methods into the thing that includes this module
    def self.included(controller) # :nodoc:
      controller.send(:include, InstanceMethods)
      controller.extend(ClassMethods)
    end

    module ClassMethods
      def self.extended(controller)
        # We want these to be available to view too, so make them
        # helpers
        controller.helper_method :current_user, :logged_in?, :auth_required
        # We're mixing these into a controller, but we don't want them
        # to be controller actions
        controller.hide_action :current_user, :logged_in?, :auth_required
      end
    end

    # I don't like this as much, because I think you have to put it
    # after method definitions
#     def self.included(base)
#       base.send :helper_method, :current_user, :logged_in? if base.respond_to? :helper_method
#     end

    module InstanceMethods
      def logged_in?
        !!current_user
      end

      def current_user
        begin 
          @current_user ||= session[:person] ? Person.find(session[:person]) : nil
        rescue
          # This happens when the session contains an ID of a person that no longer exists in the database
          @current_user = nil
        end
         
      end

      def authorized?
        logged_in?
      end

      def auth_required
        unless authorized?
          session[:return_to] = request.request_uri
          flash[:notice] = "Please log in to see this page"
          render :template => "login/index"
        end
      end
    end

  end
end
