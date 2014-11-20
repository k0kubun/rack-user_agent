require "rack/woothee/version"
require "rack/woothee/helper"

module Rack
  class Woothee
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      @app.call(env)
    end
  end

  class Request
    include Rack::Woothee::Helper
  end
end
