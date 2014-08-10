#!/usr/bin/env ruby

class BasicLog  
  def logger(message)
    log_file = File.open("log.txt", "a")    
    log_file.puts("[#{Time.now}]: #{message}")
    log_file.close()
  end
end