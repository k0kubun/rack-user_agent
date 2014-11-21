require_relative "../../spec_helper"

describe "Rack::UserAgent" do
  include Rack::Test::Methods

  let(:app) do
    dummy_app = ->(env) { [200, {}, "Hello World"] }
    Rack::UserAgent.new(dummy_app)
  end
  let(:ua) { "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25" }
  let(:woothee_result) { ::Woothee.parse(ua) }

  it "assigns woothee parse result to env['rack.woothee']" do
    header "User-Agent", ua
    get "/"
    last_request.env["rack.woothee"].must_equal woothee_result
  end
end
