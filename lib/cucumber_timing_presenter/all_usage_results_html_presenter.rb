module DistributedLife
  class AllUsageResultsHtmlPresenter < UsageRecordHtmlPresenter
    def initialize usage_record
      html = generate_html usage_record

      output html
    end

    def generate_html usage
      file_string = ""
      File.open("templates/usage.template.html") do |file|
        while line = file.gets
          file_string = "#{file_string}#{line}"
        end
      end

      file_string.gsub!("PP_STEP_HIGHEST_AVERAGE", "#{format_usage(usage.highest_average)}")
      file_string.gsub!("PP_STEP_HIGHEST_ELAPSED_TIME", "#{format_usage(usage.highest_elapsed_time)}")
      file_string.gsub!("PP_STEP_GREATEST_VARIATION", "#{format_usage(usage.greatest_variation)}")
      file_string = "#{file_string.split("PP_ALL_STEPS").first}#{format_all(usage.all)}#{file_string.split("PP_ALL_STEPS").last}"

      file_string
    end
  end
end