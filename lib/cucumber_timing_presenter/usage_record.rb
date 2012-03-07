module DistributedLife
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
        usage[:total] = usage[:instances].sum
        usage[:occurances] = usage[:instances].count
        usage[:average] = usage[:total] / usage[:occurances]
        usage[:fastest] = usage[:instances].sort.first
        usage[:slowest] = usage[:instances].sort.last
        usage[:variation] = usage[:slowest] - usage[:fastest]
      end
    end

    def all
      @record
    end

    def sort_by_property property
      @record.sort {|a,b| a.last[property.to_sym] <=> b.last[property.to_sym]}.last
    end

    def highest_average
      sort_by_property :average
    end

    def highest_elapsed_time
      sort_by_property :total
    end

    def greatest_variation
      sort_by_property :variation
    end
  end
end