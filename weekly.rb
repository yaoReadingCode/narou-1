#!/usr/bin/env ruby

require 'net/HTTP'
require 'uri'
require 'json'
require 'pry'
require 'date'


start_date = Date.parse("20130501") # ここは可変
end_date = Date.parse("20151022")

week = start_date - (start_date.wday - 2)
week = week + 7 if week < Date.parse("20130501") # こっちは固定

b = []


def get_weekly_rank(day)
  url = "http://api.syosetu.com/rank/rankget/"
  params = "?out=json&rtype=" + day.to_s + "-w"
  uri = URI.parse(url + params)

  response = Net::HTTP.start(uri.host).get(uri.request_uri)

  begin
    return JSON.parse(response.body)
  rescue
    return 1
  end
end

while week <= end_date do

  output = Hash.new("error")
  day = week.strftime("%Y%m%d")

  output.store("day", day.to_s)

  weekly_rank = get_weekly_rank(day)

  if weekly_rank != 1
    (0..9).each{|l|
    
#    output.store("ncode" + l.to_s, weekly_rank[l]["ncode"]) 
    b.push(weekly_rank[l]["ncode"])
    }
  end

#  puts output

  week = week + 7
end

puts b.uniq

# turi = URI.parse("http://api.syosetu.com/novelapi/api/?out=json&ncode=" + ncode)
# 
# t = Net::HTTP.start(turi.host, turi.port) do |http|
#  http.open_timeout = 5
#  http.read_timeout = 10
#  http.get(turi.request_uri)
# end
# 
# begin
# novel = JSON.parse(t.body)[1]
# title = novel["title"]
# general_firstup = novel["general_firstup"][/(.*) /, 1]
# novelupdated_at = novel["novelupdated_at"][/(.*) /, 1]
# general_all_no = novel["general_all_no"]
# rescue
# puts l.to_s + "\t" + hash[0]["pt"].to_s + "\t" + "error" + "\t" + "http://ncode.syosetu.com/" + hash[0]["ncode"] + "/" + "\t" + "general_firstup"
# next
# end
# 
# binding.pry
# 
# puts l.to_s + "\t" + hash[0]["pt"].to_s + "\t" + title + "\t" + "http://ncode.syosetu.com/" + hash[0]["ncode"] + "/" + "\t" + general_firstup + "\t" + novelupdated_at.to_s + "\t" + general_all_no.to_s
# 
# }
# 
