module CucumberTimingPresenter
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
      tmp_path = "tmp/cucumber_timing_presenter"
      unless File.exists? tmp_path
        Dir::mkdir tmp_path
      end
      
      File.open("tmp/cucumber_timing_presenter/#{filename}", "w") do |file|
        file.write @content
      end
    end

    def content
      @content
    end

    def replace to_remove, to_insert
      @content = "#{@content.split(to_remove).first}#{to_insert}#{@content.split(to_remove).last}"
    end
  end
end