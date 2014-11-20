module Rack
  class Woothee
    class Railtie < ::Rails::Railtie
      initializer 'rack-woothee.configure_rails_initialization' do |app|
        app.config.middleware.insert_before('ActionDispatch::ParamsParser', 'Rack::Woothee')
      end
    end
  end
end
