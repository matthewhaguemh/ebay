require File.dirname(__FILE__) + '/../test_helper'

class EbayTest < Test::Unit::TestCase
  include Ebay
  include Ebay::Types

  def setup
    @ebay = Api.new
    @success = responses(:official_time_success)
    @failure = responses(:official_time_failure)  
  end
	
  def test_build_header
	  header = {
	             'X-EBAY-API-COMPATIBILITY-LEVEL' => Ebay::Schema::VERSION.to_s,
	             'X-EBAY-API-SESSION-CERTIFICATE' => "#{Api.dev_id};#{Api.app_id};#{Api.cert}",
	             'X-EBAY-API-DEV-NAME' => Api.dev_id,
	             'X-EBAY-API-APP-NAME' => Api.app_id,
	             'X-EBAY-API-CERT-NAME' => Api.cert,
	             'X-EBAY-API-CALL-NAME' => 'GeteBayOfficialTime',
	             'X-EBAY-API-SITEID' => Api.site_id.to_s,
	             'Content-Type' => 'text/xml',
               'Accept-Encoding' => 'gzip'
	           }
    ebay = Api.new
	  assert_equal header, ebay.send(:build_headers, 'GeteBayOfficialTime', Api.site_id)
		
	end


  def test_raise_on_error
    Ebay::HttpMock.respond_with(@failure)
    assert_raise(Ebay::RequestError) do
      @ebay.get_ebay_official_time
    end 
  end

  def test_successful_request
    Ebay::HttpMock.respond_with(@success)
    response = @ebay.get_ebay_official_time
    assert response.success?
    assert_equal Time.parse('2006-07-05T14:23:03.399Z'), response.timestamp
  end
  
  def test_request_with_block
    Ebay::HttpMock.respond_with(@success)
    response = @ebay.get_ebay_official_time{ }
    assert response.success?
    assert_equal Time.parse('2006-07-05T14:23:03.399Z'), response.timestamp
  end

  def test_raise_on_error_with_errors
    Ebay::HttpMock.respond_with responses(:verify_add_item_failure)
    begin
      @ebay.verify_add_item
    rescue Ebay::RequestError => exception
      assert_equal 1, exception.errors.size
      error = exception.errors.first
      assert_equal 'Input data is invalid.', error.short_message
      assert_equal ErrorClassificationCode::RequestError, error.error_classification
    end
  end
end