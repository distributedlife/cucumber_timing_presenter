#!/usr/bin/env ruby

require 'lib/cuke_usage_parser'
require 'lib/cuke_usage_pretty_printer'

if ARGV.count == 0
  puts "Filename parameter not found. Usage: ruby parse_usage_results.rb filename"
  exit
end

usage = CukeUsageParser.new ARGV.first

file_string = ""
File.open("templates/usage.cuke_unused_steps.template.html") do |file|
  while line = file.gets
    file_string = "#{file_string}#{line}"
  end
end

file_string = "#{file_string.split("PP_UNUSED_STEPS").first}#{CukeUsagePrettyPrinter.print_all(usage.unused_steps)}#{file_string.split("PP_UNUSED_STEPS").last}"

puts file_string