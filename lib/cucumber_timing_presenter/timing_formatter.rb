require 'usage_record'
require 'unused_steps'
require 'all_usage_results_html_presenter'

module DistributedLife
  class TimingFormatter
    def initialize(step_mother, io, options)
      @step_mother = step_mother
      @io = io
      @options = options
      
      @usage_record = UsageRecord.new
      @unused_steps = UnusedSteps.new
    end

    #call backs
    def before_step(step)
      @start_time = Time.now
    end

    def before_step_result(*args)
      @duration = Time.now - @start_time
    end

    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
      @usage_record.record step_match.step_definition.regexp_source, @duration
    end

    def after_features(features)
      add_unused_stepdefs
      @usage_record.calculate

      AllUsageResultsHtmlPresenter.new @usage_record
      
#      @usage_record.all.each do |step_name, usage|
#        puts step_name
#        puts "\tcount: #{usage[:instances].count}"
#        puts "\tsum: #{usage[:instances].sum}"
#        puts "\taverage: #{usage[:instances].sum / usage[:instances].count}"
#      end
#
#      @unused_steps.all.each do |step_name, where|
#        puts "UNUSED: #{step_name} - #{where}"
#      end
    end


    #helpers
    def add_unused_stepdefs
      @step_mother.unmatched_step_definitions.each do |step_definition|
        @unused_steps.record step_definition.regexp_source, step_definition.file_colon_line
      end
    end
  end
end