# Rack::Woothee

Rack middleware to parse User-Agent and set parameters to HTTP::Request, using [woothee](https://github.com/woothee/woothee-ruby).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-woothee'
```

## Usage

### Rails

If you bundle "rack-woothee", Rack::Woothee will be automatically inserted when started.  
Additional methods for `request` will be available with no cost.

```ruby
class ApplicationController < ActionController::Base
  before_action :set_request_variant

  def index
    request.env["HTTP_USER_AGENT"] #=> "Mozilla/5.0 (Macintosh; ..."
    request.device_type            #=> :pc
    request.os                     #=> "Mac OSX"
    request.browser                #=> "Chrome"
    request.from_pc?               #=> true
    request.from_smartphone?       #=> false
  end

  private

  # It is useful for Action Pack variants, which is new feature from Rails4.1.
  # You can switch view templates by +pc or +smartphone in file name.
  # http://guides.rubyonrails.org/4_1_release_notes.html#action-pack-variants
  def set_request_variant
    request.variant = request.device_type # :pc, :smartphone
  end
end
```

## License

MIT License
