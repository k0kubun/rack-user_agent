require "rack/woothee/result"

# This module aims to provide APIs compatible with:
# https://github.com/ihara2525/rack-smartphone_detector
module Rack
  class Woothee
    module Detector
      include Result

      alias :smartphone_version :os_version
      def smartphone_version
        suppress_unknown(os_version)
      end

      def from_iphone?
        os == "iPhone"
      end

      def from_ipad?
        os == "iPad"
      end

      def from_android?
        os == "Android"
      end

      private

      def suppress_unknown(version)
        if version == "UNKNOWN"
          nil
        else
          version
        end
      end
    end
  end
end
