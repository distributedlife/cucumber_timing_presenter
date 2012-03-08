module CucumberTimingPresenter
  class UsageRecord
    def initialize
      @record = Hash.new
    end

    def record step_name, duration
      result = @record[step_name]
      result ||= Hash.new
      result[:instances] ||= []
      result[:instances] << duration

      @record[step_name] ||= result
    end

    def calculate
      @record.each do |key, usage|
        usage[:total] = usage[:instances].inject{|sum,x| sum + x }
        usage[:occurances] = usage[:instances].count
        usage[:average] = usage[:total].to_f / usage[:occurances].to_f
        usage[:fastest] = usage[:instances].sort.first
        usage[:slowest] = usage[:instances].sort.last
        usage[:variation] = usage[:slowest] - usage[:fastest]
        usage[:variance] = self.sample_variance usage[:instances]
        usage[:standard_deviation] = self.standard_deviation usage[:variance]
      end
    end

    def all
      @record
    end

    def sort_by_property property
      @record.sort {|a,b| a.last[property.to_sym] <=> b.last[property.to_sym]}
    end

    def highest_average
      sort_by_property(:average).reverse.first
    end

    def highest_elapsed_time
      sort_by_property(:total).reverse.first
    end

    def greatest_variation
      sort_by_property(:variation).reverse.first
    end

    def average_times_plot_data
      @record.map {|step_name, data| data[:average].to_f}
    end

    def total_times_plot_data
      @record.map {|step_name, data| data[:total].to_f}
    end

    def step_part_of_total
      @record.map {|step_name, data| data[:total]}.sort.reverse
    end

    def total_elapsed_time
      @record.map {|step_name, data| data[:total]}.inject{|sum,x| sum + x }
    end

    def sample_variance data
      occurances = data.count
      average = data.inject{|sum,x| sum + x } / occurances.to_f

      return nil if occurances <= 1
      
      sum = data.inject(0){|acc,i|acc.to_f + (i.to_f - average)**2.0}

      return 1 / (occurances.to_f - 1.0) * sum.to_f
    end

    def standard_deviation sample_variance
      return nil if sample_variance.nil?
      
      return Math.sqrt(sample_variance)
    end
  end
end