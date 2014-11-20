module Rack
  class Woothee
    module Checker
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
    end
  end
end
