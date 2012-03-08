module CucumberTimingPresenter
  class UnusedSteps
    def initialize
      @record = Hash.new
    end

    def record step_name, where
      result = @record[step_name]
      result = where

      @record[step_name] ||= result
    end

    def all
      @record
    end
  end
end