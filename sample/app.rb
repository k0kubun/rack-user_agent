require "sinatra"
require "pry"

configure do
end

get "/" do
  binding.pry
  "hell"
end
