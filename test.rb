#!/usr/bin/env ruby

require 'net/HTTP'
require 'uri'
require 'json'
require 'pry'
require 'date'

url = "http://api.syosetu.com/rank/rankget/"

#day = 20150916

(Date.parse("20130501")..Date.parse("20151004")).each{|l|
output = Hash.new("error")

day = l.strftime("%Y%m%d")
output.store("day",l.to_s)

params = "?out=json&rtype=" + day + "-d"

uri = URI.parse(url + params)

response = Net::HTTP.start(uri.host).get(uri.request_uri)
begin
hash = JSON.parse(response.body)
rescue
puts l.to_s + "\t" + "error"
next
end



turi = URI.parse("http://api.syosetu.com/novelapi/api/?out=json&ncode=" + ncode)

t = Net::HTTP.start(turi.host, turi.port) do |http|
 http.open_timeout = 5
 http.read_timeout = 10
 http.get(turi.request_uri)
end

begin
novel = JSON.parse(t.body)[1]
title = novel["title"]
general_firstup = novel["general_firstup"][/(.*) /, 1]
novelupdated_at = novel["novelupdated_at"][/(.*) /, 1]
general_all_no = novel["general_all_no"]
rescue
puts l.to_s + "\t" + hash[0]["pt"].to_s + "\t" + "error" + "\t" + "http://ncode.syosetu.com/" + hash[0]["ncode"] + "/" + "\t" + "general_firstup"
next
end

binding.pry

puts l.to_s + "\t" + hash[0]["pt"].to_s + "\t" + title + "\t" + "http://ncode.syosetu.com/" + hash[0]["ncode"] + "/" + "\t" + general_firstup + "\t" + novelupdated_at.to_s + "\t" + general_all_no.to_s

}




def get_day_ranking(day)
  base_url = "http://api.syosetu.com/rank/rankget/"
  params = "?out=json&rtype=" + day + "-d"
  uri = URI.parse(url + params)
  
  return Net::HTTP.start(uri.host).get(uri.request_uri)
end

(Date.parse("20130501")..Date.parse("20151004")).each{|l|


  day = l.strftime("%Y%m%d")
    
  begin
    hash_day_ranking = JSON.parse(get_day_ranking(day).body)
  rescue
    puts l.to_s + "\t" + "error"
    next
  end

ncode_day_ranking = hash_day_ranking[0]["ncode"]


