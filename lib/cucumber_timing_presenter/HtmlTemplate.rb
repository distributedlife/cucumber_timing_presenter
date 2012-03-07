module DistributedLife
  class HtmlTemplate
    def initialize template_path
      @content = ""

      File.open(template_path) do |file|
        while line = file.gets
          @content = "#{@content}#{line}"
        end
      end
    end

    def output filename
#      File.open("tmp/cucumber_timing_presenter/all_usage_results.html", "w") do |file|
      File.open("tmp/#{filename}", "w") do |file|
        file.write @content
      end
    end

    def replace to_remove, to_insert
      if to_insert.length < 2048
        @content.gsub!(to_remove, to_insert)
      else
        @content = "#{@content.split(to_remove).first}#{to_insert}#{@content.split(to_remove).last}"
      end
    end
  end
end