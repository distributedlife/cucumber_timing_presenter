module DistributedLife
  class UsageRecordHtmlPresenter
    def format_usage usage
      step_name = usage.first
      step_usage = usage.last
      
      html = "<table><trbody>"
      html = "#{html}<tr><th style='text-align:right;'>step</th><td style='padding-left:0.6em;'><pre>#{step_name}</pre></td></tr>"
      step_usage.each do |key, value|
        next if key == :instances
        
        html = "#{html}<tr><th style='text-align:right;'>#{key}</th><td style='padding-left:0.6em;'><pre>#{value}</pre></td></tr>"
      end
      html = "#{html}</trbody></table>"

      html
    end

    def format_all all_usage
      output = ""
      
      all_usage.each do |result|
        output = "#{output}#{format_usage(result)}<hr/>"
      end

      output
    end

    def output content
      File.open("tmp/all_usage_results.html", "w") do |file|
        file.write content
      end
    end
  end
end