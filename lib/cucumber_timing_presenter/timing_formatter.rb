module CucumberTimingPresenter
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

    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)

      step_definition = step_match.step_definition
      unless step_definition.nil? # nil if it's from a scenario outline
        @usage_record.record step_definition.regexp_source, @duration
      end
    end

    def after_features(features)
      get_unused_stepdefs

      @usage_record.calculate

      AllUsageResultsHtmlPresenter.new @usage_record
      UnusedStepsHtmlPresenter.new @unused_steps
      StepAverageAndTotalHtmlPresenter.new @usage_record
      StepTimesOfWholeHtmlPresenter.new @usage_record
    end


    #helpers
    def get_unused_stepdefs
      @step_mother.unmatched_step_definitions.each do |step_definition|
        @unused_steps.record step_definition.regexp_source, step_definition.file_colon_line
      end
    end
  end
end