#!/usr/bin/env ruby

if ARGV.count < 2
  puts "Incorrect usage. Correct usage is: ruby run_all.rb source_data_file output/path/"
  exit
end

usage_path = ARGV.first
output_path = ARGV.last
output_path = "#{output_path}/" unless output_path[-1] == "/"

`./cuke_usage_results.rb #{usage_path} > #{output_path}/cuke_usage_results.html`
`./cuke_unused_steps.rb #{usage_path} > #{output_path}/cuke_unused_steps.html`
`./cuke_step_times_total_of_whole.rb #{usage_path} > #{output_path}/cuke_step_times_total_of_whole.html`
`./cuke_step_average_and_total.rb #{usage_path} > #{output_path}/cuke_step_average_and_total.html`