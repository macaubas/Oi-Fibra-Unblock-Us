#!/usr/bin/env ruby
require 'yaml'

class Settings
  def initialize(filepath)
    @config_file = YAML.load_file(filepath)
  end

  def get
    @config_file
  end
end