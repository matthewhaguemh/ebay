require 'ebay/types/fee'

module Ebay
  module Responses
    class VerifyAddSecondChanceItem < Abstract
      include XML::Mapping
      include Initializer
      root_element_name 'VerifyAddSecondChanceItemResponse'
      array_node :fees, 'Fees', 'Fee', :class => Fee, :default_value => []
      time_node :start_time, 'StartTime', :optional => true
      time_node :end_time, 'EndTime', :optional => true
    end
  end
end

