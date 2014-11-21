require "woothee"
require "rack/woothee/checker"
require "rack/woothee/detector"
require "rack/woothee/result"
require "rack/woothee/version"
require 'rack/woothee/railtie' if defined?(Rails::Railtie)

module Rack
  class UserAgent
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      env["rack.woothee"] = ::Woothee.parse(env["HTTP_USER_AGENT"] || "")
      @app.call(env)
    end
  end

  class Request
    include Rack::UserAgent::Checker
    include Rack::UserAgent::Detector
    include Rack::UserAgent::Result
  end
end
