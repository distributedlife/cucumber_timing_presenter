#!/usr/bin/env ruby

require 'lib/cuke_usage_parser'
require 'lib/cuke_usage_pretty_printer'

if ARGV.count == 0
  puts "Filename parameter not found. Usage: ruby parse_usage_results.rb filename"
  exit
end

usage = CukeUsageParser.new ARGV.first

file_string = ""
File.open("templates/usage.template.html") do |file|
  while line = file.gets
    file_string = "#{file_string}#{line}"
  end
end

file_string.gsub!("PP_STEP_HIGHEST_AVERAGE", "#{CukeUsagePrettyPrinter.print(usage.highest_average)}")
file_string.gsub!("PP_STEP_HIGHEST_ELAPSED_TIME", "#{CukeUsagePrettyPrinter.print(usage.highest_elapsed_time)}")
file_string.gsub!("PP_STEP_GREATEST_VARIATION", "#{CukeUsagePrettyPrinter.print(usage.greatest_variation)}")
file_string = "#{file_string.split("PP_ALL_STEPS").first}#{CukeUsagePrettyPrinter.print_all(usage.all)}#{file_string.split("PP_ALL_STEPS").last}"

puts file_string