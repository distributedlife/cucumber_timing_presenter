#!/usr/bin/env ruby

require 'lib/cuke_usage_parser'
require 'lib/cuke_usage_pretty_printer'

if ARGV.count == 0
  puts "Filename parameter not found. Usage: ruby parse_usage_results.rb filename"
  exit
end

usage = CukeUsageParser.new ARGV.first

file_string = ""
File.open("templates/usage.cuke_step_times_total_of_whole.template.html") do |file|
  while line = file.gets
    file_string = "#{file_string}#{line}"
  end
end


file_string.gsub!("PP_STEP_TOTAL_TIMES_PLOT_DATA", "#{usage.step_part_of_total.join(',')}")
file_string.gsub!("PP_TOTAL_ELAPSED_TIME", "#{usage.total_elapsed_time / 60}")

puts file_string