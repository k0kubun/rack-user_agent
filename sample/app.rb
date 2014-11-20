require "sinatra"
require "pry"
require "rack/woothee"

configure do
  use Rack::Woothee
end

get "/" do
  if request.from_smartphone?
    "smartphone"
  else
    "pc"
  end
end
