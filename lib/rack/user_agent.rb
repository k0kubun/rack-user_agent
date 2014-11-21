require "woothee"
require "rack/user_agent/checker"
require "rack/user_agent/detector"
require "rack/user_agent/result"
require "rack/user_agent/version"
require 'rack/user_agent/railtie' if defined?(Rails::Railtie)

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
