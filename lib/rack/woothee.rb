require "woothee"
require "rack/woothee/version"
require "rack/woothee/helper"

module Rack
  class Woothee
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      env["rack.woothee"] = ::Woothee.parse(env["HTTP_USER_AGENT"])
      @app.call(env)
    end
  end

  class Request
    include Rack::Woothee::Helper
  end
end
