module CucumberTimingPresenter
  class StepAverageAndTotalHtmlPresenter < UsageRecordHtmlPresenter
    def initialize usage_record
      generate_html usage_record
    end

    def generate_html usage
      html = HtmlTemplate.new Configuration.step_average_and_total

      html.replace "PP_HIGHEST_TOTAL_STEP_TIME", usage.highest_elapsed_time.last[:total]
      html.replace "PP_HIGHEST_AVERAGE_STEP_TIME", usage.highest_average.last[:average]
      html.replace "PP_AVERAGE_TIMES_PLOT_DATA", usage.average_times_plot_data.join(',')
      html.replace "PP_TOTAL_TIMES_PLOT_DATA", usage.total_times_plot_data.join(',')
      
      html.output "step_average_and_total.html"
    end
  end
end