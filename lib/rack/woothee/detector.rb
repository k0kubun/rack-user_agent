require "rack/woothee/result"

# This module aims to provide APIs compatible with:
# https://github.com/ihara2525/rack-smartphone_detector
module Rack
  class Woothee
    module Detector
      include Result

      alias :smartphone_version :os_version

      def from_iphone?
        os == "iPhone"
      end

      def from_ipad?
        os == "iPad"
      end

      def from_android?
        os == "Android"
      end
    end
  end
end
