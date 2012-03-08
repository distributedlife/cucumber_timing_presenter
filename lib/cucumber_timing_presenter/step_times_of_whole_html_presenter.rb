module CucumberTimingPresenter
  class StepAverageAndTotalHtmlPresenter < UsageRecordHtmlPresenter
    def initialize usage_record
      generate_html usage_record
    end

    def generate_html usage
      html = HtmlTemplate.new Configuration.step_times_of_whole

      html.replace "PP_STEP_TOTAL_TIMES_PLOT_DATA", usage.step_part_of_total.join(',')
      html.replace "PP_TOTAL_ELAPSED_TIME", usage.total_elapsed_time / 60

      html.output "step_times_of_whole.html"
    end
  end
end