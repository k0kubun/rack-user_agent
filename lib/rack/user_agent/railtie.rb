module Rack
  class UserAgent
    class Railtie < ::Rails::Railtie
      initializer "rack-user_agent.configure_rails_initialization" do |app|
        app.config.middleware.insert_after(Rack::Head, Rack::UserAgent)
      end
    end
  end
end
