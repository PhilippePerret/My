#!/usr/bin/env ruby
# encoding: UTF-8

# On require toute la librairie
require_relative '../lib/required'


# My.test

begin
  My.init
  My.run
rescue Exception => e
  puts "ERREUR FATALE : #{e.message}"
  puts e.backtrace.join("\n")
end
