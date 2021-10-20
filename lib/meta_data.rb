# frozen_string_literal: true

require 'happymapper'

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
