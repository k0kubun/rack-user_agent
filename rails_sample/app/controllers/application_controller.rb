class ApplicationController < ActionController::Base
  REQUEST_METHODS = %i[
    device_type os os_version smartphone_version browser browser_version browser_vendor
    from_pc? from_smartphone? from_mobilephone? from_appliance? from_crawler?
    from_iphone? from_ipad? from_android? from_android_tablet? from_windows_phone?
  ].freeze

  def index
    @result = {}

    REQUEST_METHODS.each do |method|
      @result[method] = request.public_send(method)
    end
  end
end
