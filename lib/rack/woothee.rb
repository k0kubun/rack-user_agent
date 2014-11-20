require "rack/woothee/checker"
require "rack/woothee/result"
require "rack/woothee/version"
require "woothee"

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
    include Rack::Woothee::Result
    include Rack::Woothee::Checker
  end
end
