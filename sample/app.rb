require "sinatra"
require "pry"
require "rack/woothee"

configure do
  use Rack::Woothee
end

get "/" do
  methods = %i[
    device_type os os_version browser browser_version browser_vendor
    from_pc? from_smartphone? from_mobilephone? from_appliance? from_crawler?
  ]
  methods.map { |m| "#{m}: #{request.send(m)}" }.join("<br>")
end
