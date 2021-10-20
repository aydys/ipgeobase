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
    include HappyMapper

    tag 'query'
    element :city, String
    element :country, String
    element :countryCode, String, tag: 'countryCode'
    element :lat, Float
    element :lon, Float
  end

  def lookup(ip)
    uri = Addressable::URI.parse("https://ip-api.com/xml/#{ip}")
    res = Net::HTTP.get_response(uri.normalize)
    MetaData.parse(res.body, single: true)
  end
  module_function :lookup
end
