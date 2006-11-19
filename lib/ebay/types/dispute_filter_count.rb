
module Ebay
  module Types
    class DisputeFilterCount
      include XML::Mapping
      include Initializer
      root_element_name 'DisputeFilterCount'
      text_node :dispute_filter_type, 'DisputeFilterType', :optional => true
      numeric_node :total_available, 'TotalAvailable', :optional => true
    end
  end
end

