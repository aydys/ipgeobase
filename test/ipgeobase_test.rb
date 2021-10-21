# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/ipgeobase'

class IpgeobaseTest < Minitest::Test
  def setup
    fixture = File.read(File.expand_path('./fixtures/fixture.xml', __dir__))
    @stub_get = stub_request(:get, 'https://ip-api.com/xml/8.8.8.8')
                .to_return(status: 200, body: fixture)
    @ip_meta = Ipgeobase.lookup('8.8.8.8')
  end

  def test_that_object_get_meta_data
    assert_requested(@stub_get)
    assert(@ip_meta.city == 'Ashburn')
    assert(@ip_meta.country == 'United States')
    assert(@ip_meta.countryCode == 'US')
    assert(@ip_meta.lat * 100 == 3903)
    assert(@ip_meta.lon * 10 == -775)
  end
end
