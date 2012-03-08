module CucumberTimingPresenter
  class AllUsageResultsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize usage_record
      generate_html usage_record
    end

    def generate_html usage
      html = HtmlTemplate.new Configuration.usage_template_path
      html.replace "PP_STEP_HIGHEST_AVERAGE", format_usage(usage.highest_average)
      html.replace "PP_STEP_HIGHEST_ELAPSED_TIME", format_usage(usage.highest_elapsed_time)
      html.replace "PP_STEP_GREATEST_VARIATION", format_usage(usage.greatest_variation)
      html.replace "PP_ALL_STEPS", format_all(usage.all)
      Htmlhtml.output "all_usage_results.html"
    end
  end
end