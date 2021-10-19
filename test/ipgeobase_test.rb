# frozen_string_literal: true

require_relative "test_helper"
require_relative "../lib/ipgeobase"

class IpgeobaseTest < Minitest::Test
  def setup
    stub_request(:get, "https://ip-api.com/xml/8.8.8.8")
      .to_return(status: 200, body: '<query>'\
        '<country>United States</country>'\
        '<countryCode>US</countryCode>'\
        '<city>Ashburn</city>'\
        '<lat>39.03</lat>'\
        '<lon>-77.5</lon>'\
    '</query>')
    @ip_meta = Ipgeobase.lookup('8.8.8.8')
  end

  def test_that_object_get_meta_data
    assert(@ip_meta.city == 'Ashburn')
    assert(@ip_meta.country == 'United States')
    assert(@ip_meta.countryCode == 'US')
    assert(@ip_meta.lat == 39.03)
    assert(@ip_meta.lon == -77.5)
  end
end