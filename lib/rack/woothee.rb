require "woothee"
require "rack/woothee/checker"
require "rack/woothee/detector"
require "rack/woothee/result"
require "rack/woothee/version"
require 'rack/woothee/railtie' if defined?(Rails::Railtie)

module Rack
  class Woothee
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      env["rack.woothee"] = ::Woothee.parse(env["HTTP_USER_AGENT"] || "")
      @app.call(env)
    end
  end

  class Request
    include Rack::Woothee::Checker
    include Rack::Woothee::Detector
    include Rack::Woothee::Result
  end
end
