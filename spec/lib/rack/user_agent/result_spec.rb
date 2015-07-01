require_relative "../../../spec_helper"

describe "Rack::UserAgent::Result" do
  include Rack::Test::Methods

  let(:app) do
    dummy_app = ->(env) { [200, {}, "Hello World"] }
    Rack::UserAgent.new(dummy_app)
  end
  let(:ua) { "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25" }
  let(:woothee_result) { ::Woothee.parse(ua) }
  let(:mappings) do
    {
      device_type:     :category,
      os:              :os,
      os_version:      :os_version,
      browser:         :name,
      browser_version: :version,
      browser_vendor:  :vendor,
    }
  end

  it "returns proper woothee results" do
    header "User-Agent", ua
    get "/"

    mappings.each do |method, original|
      last_request.public_send(method).must_equal woothee_result[original]
    end
  end

  describe "UNKNOWN category" do
    let(:ua) { "ELB-HealthChecker/1.0" }

    it "device_type should return symbol" do
      header "User-Agent", ua
      get "/"

      woothee_result[:category].must_equal Woothee::VALUE_UNKNOWN
      last_request.device_type.must_equal Woothee::VALUE_UNKNOWN.to_sym
      last_request.device_type.class.must_equal Symbol
    end
  end
end
