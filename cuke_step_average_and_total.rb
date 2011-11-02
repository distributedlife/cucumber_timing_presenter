#!/usr/bin/env ruby

require 'lib/cuke_usage_parser'
require 'lib/cuke_usage_pretty_printer'

if ARGV.count == 0
  puts "Filename parameter not found. Usage: ruby parse_usage_results.rb filename"
  exit
end

usage = CukeUsageParser.new ARGV.first

file_string = ""
File.open("templates/usage.cuke_step_average_and_total.template.html") do |file|
  while line = file.gets
    file_string = "#{file_string}#{line}"
  end
end

file_string.gsub!("PP_HIGHEST_TOTAL_STEP_TIME", "#{usage.highest_elapsed_time["total"]}")
file_string.gsub!("PP_HIGHEST_AVERAGE_STEP_TIME", "#{usage.highest_average["average"]}")
file_string.gsub!("PP_AVERAGE_TIMES_PLOT_DATA", "#{usage.average_times_plot_data.join(',')}")
file_string.gsub!("PP_TOTAL_TIMES_PLOT_DATA", "#{usage.total_times_plot_data.join(',')}")

puts file_string