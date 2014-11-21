require_relative "../../../spec_helper"

# Vendored from:
# https://github.com/ihara2525/rack-smartphone_detector/blob/master/spec/rack-smartphone_detector_spec.rb
describe "Rack::Woothee::Detector" do
  include Rack::Test::Methods

  SMARTPHONES = [
    {
      name: "iPhone",
      version: "5.1.1",
      user_agents: [
        "Mozilla/5.0 (iPhone; CPU iPhone OS 5_1_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B206 Safari/7534.48.3",
      ]
    },
    {
      name: "iPhone",
      version: "6.0",
      user_agents: [
        "Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25",
      ]
    },
    {
      name: "iPad",
      version: "6.0",
      user_agents: [
        "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A403 Safari/8536.25"
      ]
    },
    {
      name: "Android",
      version: "4.0.1",
      user_agents: [
        "Mozilla/5.0 (Linux; U; Android 4.0.1; ja-jp; Galaxy Nexus Build/ITL41D) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30",
      ]
    },
    {
      name: "Android",
      version: "4.2.1",
      user_agents: [
        "Opera/9.80 (Android 4.2.1; Linux; Opera Mobi/ADR-1301080958) Presto/2.11.355 Version/12.10"
      ]
    },
    {
      name: "Android",
      version: nil,
      user_agents: [
        "Mozilla/5.0 (Android; Mobile; rv:18.0) Gecko/18.0 Firefox/18.0",
      ]
    },
    {
      name: "Android Tablet",
      version: "4.1.1",
      user_agents: [
        "Mozilla/5.0 (Linux; Android 4.1.1; Nexus 7 Build/JRO03S) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Safari/535.19"
      ]
    },
    {
      name: "Windows Phone",
      version: "7.5",
      user_agents: [
        "Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0; FujitsuToshibaMobileCommun; IS12T; KDDI)"
      ]
    }
  ]

  let(:app) do
    dummy_app = ->(env) { [200, {}, "Hello World"] }
    Rack::Woothee.new(dummy_app)
  end

  describe "#from_smartphone?" do
    it "returns true if the request comes from smartphone" do
      SMARTPHONES.each do |info|
        info[:user_agents].each do |ua|
          header "User-Agent", ua
          get "/"
          last_request.from_smartphone?.must_equal true
        end
      end
    end

    it "returns false if the request does not come from smartphone" do
      [
        "DoCoMo/2.0 F01E(c500;TB;W24H16)",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.101 Safari/537.11"
      ].each do |ua|
        header "User-Agent", ua
        get "/"
        last_request.from_smartphone?.must_equal false
      end
    end

    it "returns false if the request comes from device without user-agent" do
      get "/"
      last_request.from_smartphone?.must_equal false
    end
  end

  describe "#smartphone_version" do
    it "returns version number string if it could be detected" do
      SMARTPHONES.each do |info|
        info[:user_agents].each do |ua|
          header "User-Agent", ua
          get "/"
          last_request.smartphone_version.must_equal info[:version]
        end
      end
    end
  end

  describe "#from_iphone?" do
    it "returns true if the request comes from iphone" do
      user_agents("iPhone").each do |ua|
        header "User-Agent", ua
        get "/"
        last_request.from_iphone?.must_equal true
      end
    end
  end

  describe "#from_ipad?" do
    it "returns true if the request comes from ipad" do
      user_agents("iPad").each do |ua|
        header "User-Agent", ua
        get "/"
        last_request.from_ipad?.must_equal true
      end
    end
  end

  describe "#from_android?" do
    it "returns true if the request comes from android mobile" do
      user_agents("Android").each do |ua|
        header "User-Agent", ua
        get "/"
        last_request.from_android?.must_equal true
      end
    end
  end

  # describe "#from_android_tablet?" do
  #   it "returns true if the request comes from android tablet" do
  #     user_agents("Android Tablet").each do |ua|
  #       header "User-Agent", ua
  #       get "/"
  #       last_request.from_android_tablet?.must_equal true
  #     end
  #   end
  # end

  # describe "#from_windows_phone?" do
  #   it "returns true if the request comes from windows phone" do
  #     user_agents("Windows Phone").each do |ua|
  #       header "User-Agent", ua
  #       get "/"
  #       last_request.from_windows_phone?.must_equal true
  #     end
  #   end
  # end

  def user_agents(name)
    SMARTPHONES.find { |info| info[:name] == name }[:user_agents]
  end
end
