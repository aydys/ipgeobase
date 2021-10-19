# frozen_string_literal: true

require_relative 'ipgeobase/version'
require 'addressable/uri'
require 'net/http'
require 'happymapper'

# main module
module Ipgeobase
  class Error < StandardError; end
  # Your code goes here...

  # the class create an object for the 'lookup' method result
  class MetaData
    attr_reader :city, :country, :countryCode, :lat, :lon # rubocop:disable Naming/MethodName

    def initialize(parsed)
      @city = parsed.city
      @country = parsed.country
      @countryCode = parsed.country_code  # rubocop:disable Naming/VariableName
      @lat = parsed.lat.to_f
      @lon = parsed.lon.to_f
    end
  end

  def lookup(ip)
    uri = Addressable::URI.parse("https://ip-api.com/xml/#{ip}")
    res = Net::HTTP.get_response(uri.normalize)
    parsed = HappyMapper.parse(res.body)
    MetaData.new(parsed)
  end
  module_function :lookup
end
