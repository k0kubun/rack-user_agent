module Rack
  class Woothee
    module Helper
      def device_type
        woothee_result[:category]
      end

      def os
        woothee_result[:os]
      end

      def os_version
        woothee_result[:os_version]
      end

      def browser
        woothee_result[:name]
      end

      def browser_version
        woothee_result[:version]
      end

      def browser_vendor
        woothee_result[:vendor]
      end

      def from_pc?
        device_type == :pc
      end

      def from_smartphone?
        device_type == :smartphone
      end

      def from_mobilephone?
        device_type == :mobilephone
      end

      def from_appliance?
        device_type == :appliance
      end

      def from_crawler?
        device_type == :crawler
      end

      private

      def woothee_result
        env["rack.woothee"]
      end
    end
  end
end
