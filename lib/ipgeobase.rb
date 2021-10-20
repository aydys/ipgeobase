# frozen_string_literal: true

require 'addressable/uri'
require 'net/http'
require_relative 'ipgeobase/version'
require_relative 'meta_data'

# main module
module Ipgeobase
  class Error < StandardError; end
  # Your code goes here...

  def lookup(ip)
    uri = Addressable::URI.parse("https://ip-api.com/xml/#{ip}")
    res = Net::HTTP.get_response(uri.normalize)
    MetaData.parse(res.body, single: true)
  end
  module_function :lookup
end
