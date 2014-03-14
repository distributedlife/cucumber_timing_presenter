require 'fileutils'

module CucumberTimingPresenter
  class Configuration

    class << self

      $tmp_path = 'tmp/cucumber_timing_presenter'
      #def tmp_path
      #  resolve_path_from_root
      #end

      def tmp_dir
        dir = resolve_path_from_root $tmp_path
        FileUtils.mkdir_p dir unless File.exists? dir

        dir
      end

      def tmp_file(filename)
        "#{tmp_dir}/#{filename}"
      end


      def resolve_path_from_root(relative_path)
        if defined?(Rails)
          Rails.root.join(relative_path)
        elsif defined?(Rake.original_dir)
          File.expand_path(relative_path, Rake.original_dir)
        else
          File.expand_path(relative_path, Dir.pwd)
        end
      end

      def usage_template_path
        File.expand_path('templates/all_usage_results.html', File.dirname(__FILE__))
      end

      def unused_steps_template_path
        File.expand_path('templates/unused_steps.html', File.dirname(__FILE__))
      end

      def step_times_of_whole
        File.expand_path('templates/step_times_of_whole.html', File.dirname(__FILE__))
      end

      def step_average_and_total
        File.expand_path('templates/step_average_and_total.html', File.dirname(__FILE__))
      end
    end
  end
end