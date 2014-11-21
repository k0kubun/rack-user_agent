require "sinatra"
require "pry"
require "rack/user_agent"

configure do
  use Rack::UserAgent
end

get "/" do
  methods = %i[
    device_type os os_version smartphone_version browser browser_version browser_vendor
    from_pc? from_smartphone? from_mobilephone? from_appliance? from_crawler?
    from_iphone? from_ipad? from_android? from_android_tablet? from_windows_phone?
  ]
  methods.map { |m| "#{m}: #{request.send(m)}" }.join("<br>")
end
