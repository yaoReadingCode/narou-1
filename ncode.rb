#!/usr/bin/env ruby

require 'net/HTTP'
require 'uri'
require 'json'
require 'pry'
require 'date'

def get_by_ncode(ncode)
  output = Hash.new("error")
  output.store("ncode", ncode)
  
  uri = URI.parse("http://api.syosetu.com/novelapi/api/?out=json&ncode=" + ncode)
  
  begin
    response = JSON.parse(Net::HTTP.start(uri.host, uri.port).get(uri.request_uri).body)[1]
    output.store("title", response["title"])
  rescue
    return output
  end
  
puts output
binding.pry
  return output
end

# puts get_by_ncode("N1443BP")


