module Rack
  class UserAgent
    class Railtie < ::Rails::Railtie
      initializer "rack-user_agent.configure_rails_initialization" do |app|
        app.config.middleware.insert_after(Rack::Head, Rack::UserAgent)

        ActiveSupport.on_load(:action_controller) do
          ActionDispatch::Request.class_eval do
            include Rack::UserAgent::Checker
            include Rack::UserAgent::Detector
            include Rack::UserAgent::Result
          end
        end
      end
    end
  end
end
