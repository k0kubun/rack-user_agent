require_relative "../../../spec_helper"

describe "Rack::Woothee::Checker" do
  include Rack::Test::Methods

  let(:app) do
    dummy_app = ->(env) { [200, {}, "Hello World"] }
    Rack::Woothee.new(dummy_app)
  end
  let(:expects_by_ua) do
    {
      "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; 2004/11/08; GoogleT5; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)" => {
        from_pc?:          true,
        from_smartphone?:  false,
        from_mobilephone?: false,
        from_appliance?:   false,
        from_crawler?:     false,
      },
      "Opera/9.80 (Android; Opera Mini/6.5.27452/26.1305; U; ja) Presto/2.8.119 Version/10.54" => {
        from_pc?:          false,
        from_smartphone?:  true,
        from_mobilephone?: false,
        from_appliance?:   false,
        from_crawler?:     false,
      },
      "DoCoMo/2.0 N07B(c500;TB;W24H16)" => {
        from_pc?:          false,
        from_smartphone?:  false,
        from_mobilephone?: true,
        from_appliance?:   false,
        from_crawler?:     false,
      },
      "Mozilla/5.0 (PlayStation Vita 1.51) AppleWebKit/531.22.8 (KHTML, like Gecko) Silk/3.2" => {
        from_pc?:          false,
        from_smartphone?:  false,
        from_mobilephone?: false,
        from_appliance?:   true,
        from_crawler?:     false,
      },
      "Baiduspider+(+http://www.baidu.jp/spider/)" => {
        from_pc?:          false,
        from_smartphone?:  false,
        from_mobilephone?: false,
        from_appliance?:   false,
        from_crawler?:     true,
      },
    }
  end

  it "assigns woothee parse result to env['rack.woothee']" do
    expects_by_ua.each do |ua, expects|
      header "User-Agent", ua
      get "/"

      expects.each do |method, result|
        last_request.public_send(method).must_equal result
      end
    end
  end
end
