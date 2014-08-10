#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'json'

class Unblockus  

  def initialize(email)
    random_number = ((Random.rand()*100000)+1).to_i
    url = URI.parse("http://c#{random_number}.check.unblock-us.com/get-status.js")
    cookie_body = "_stored_email_=" + email
    request_cookie = { "Cookie" => cookie_body }
    http = Net::HTTP.new(url.host,url.port)
    response = http.get(url.request_uri,request_cookie)
    @response_hash = JSON.parse(response.body.to_s[6..-4])
  end
  
  def is_our_dns
    @response_hash["our_dns"] ? true : false
  end

  def is_active
    @response_hash["is_active"] ? true : false
  end    
  
end