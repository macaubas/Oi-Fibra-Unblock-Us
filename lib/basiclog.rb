#!/usr/bin/env ruby

class BasicLog
  def initialize(filepath)
    @filepath = filepath
  end
    
  def logger(message)
    log_file = File.open(@filepath, "a")    
    log_file.puts("[#{Time.now}]: #{message}")
    log_file.close()
  end
end