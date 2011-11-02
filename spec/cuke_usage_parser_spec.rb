require 'cuke_usage_parser'
require 'spec/support/cuke_usage_generator'

describe CukeUsageParser do
  before(:all) do
    c = CukeUsageGenerator.new
    c.step_run 1, 'step one', 'source 1'
    c.step_run 3, 'step one', 'source 1'
    c.step_run 0.5, 'step two', 'source 2'
    c.steps
    c.write_to_file "test-data.dat"

    @parser = CukeUsageParser.new "test-data.dat"
  end

  before(:each) do
    `rm -f test-data.dat`
  end

  describe 'initialize' do
    it 'should report an error if the file cant be fount' do
      expect { CukeUsageParser.new "nofile.exists" }.to raise_error
    end

    it 'should skip past lines until a hash is found, this is because the usage formater sometimes ends up crap at the start' do
      parser = CukeUsageParser.new "spec/fixtures/usage_with_leading_cruft"

      parser.all.count.should == 1
      parser.all.first["name"].should == "/^user did some things that were not expected$/"
      parser.all.first["average"].should == 45.077
      parser.all.first["source"].should == "features/step_definitions/user_doing_things_steps.rb:74"
    end

    it 'should stop parsing once it reaches another blank line' do
      parser = CukeUsageParser.new "spec/fixtures/usage_with_leading_cruft"

      parser.all.count.should == 1
      parser.all.first["name"].should == "/^user did some things that were not expected$/"
      parser.all.first["average"].should == 45.077
      parser.all.first["source"].should == "features/step_definitions/user_doing_things_steps.rb:74"
    end

    describe 'for step' do
      it 'should keep track of the fastest step time (lowest is fastest)' do
        @parser.all.first["fastest"].should == 0.5
        @parser.all.last["fastest"].should == 1
      end

      it 'should keep track of the slowest step time' do
        @parser.all.first["slowest"].should == 0.5
        @parser.all.last["slowest"].should == 3
      end

      it 'should keep track of the number of times each step is called' do
        @parser.all.first["occurances"].should == 1
        @parser.all.last["occurances"].should == 2
      end

      it 'should keep track of the total execution time of each step' do
        @parser.all.first["total"].should == 0.5
        @parser.all.last["total"].should == 4
      end

      it 'should keep track of the average duration of each step' do
        @parser.all.first["average"].should == 0.5
        @parser.all.last["average"].should == 2
      end

      it 'should keep track of the source code location for the step' do
        @parser.all.first["source"].should == "source 2"
        @parser.all.last["source"].should == "source 1"
      end
    end
  end

  describe 'used_steps' do
    before(:all) do
      @parser = CukeUsageParser.new "spec/fixtures/unused_steps"
    end

    it 'should return the step of all steps that are called' do
      @parser.used_steps.count.should == 1
    end
  end

  describe 'unused_steps' do
    before(:all) do
      @parser = CukeUsageParser.new "spec/fixtures/unused_steps"
    end

    it 'should return the step of all steps that are not called' do
      @parser.unused_steps.count.should == 2
      @parser.unused_steps.first["name"].should == "/^an unused step$/"
      @parser.unused_steps.last["name"].should == "/^and another unused step$/"
    end

    it 'should not be included in highest average' do
      @parser.highest_average["average"].should_not == 0
    end

    it 'should not be included in highest_elapsed_time' do
      @parser.highest_elapsed_time["total"].should_not == 0
    end
    
    it 'should not be included in total_elapsed_time' do
      @parser.total_elapsed_time.should_not == 0
    end

    it 'should not be included in greatest variation' do
      @parser.greatest_variation["fastest"].should_not == 0
      @parser.greatest_variation["slowest"].should_not == 0
    end

    it 'should not be included in total_times_plot_data' do
      @parser.total_times_plot_data.count.should == 1
      @parser.total_times_plot_data.first.should == 0.005
    end

    it 'should not be included in average_times_plot_data' do
      @parser.average_times_plot_data.count.should == 1
      @parser.average_times_plot_data.first.should == 0.005
    end

    it 'should not be included in step_part_of_total' do
      @parser.step_part_of_total.count.should == 1
      @parser.step_part_of_total.first.should == 0.005
    end
  end

  describe 'highest_average' do
    it 'should return the step with the highest average' do
      @parser.highest_average["average"].should == 2

      @parser.highest_average.should == @parser.all.last
    end
  end

  describe 'highest_elapsed_time' do
    it 'should return the steps with the greatest total time' do
      @parser.highest_elapsed_time["total"].should == 4

      @parser.highest_elapsed_time.should == @parser.all.last
    end
  end

  describe 'total_elapsed_time' do
    it 'should return the total time for all steps' do
      @parser.total_elapsed_time.should == 4.5
    end
  end

  describe 'greatest_variation' do
    it 'should return the step with the greatest variation between fastest and slowest' do
      @parser.greatest_variation.should == @parser.all.last
    end
  end

  describe 'total_times_plot_data' do
    it 'should return the total time of each step as an array' do
      @parser.total_times_plot_data.should == [0.5, 4]
    end
  end

  describe 'average_times_plot_data' do
    it 'should return the average time of each step as an array' do
      @parser.average_times_plot_data.should == [0.5, 2]
    end
  end

  describe 'step_part_of_total' do
    it 'should return the total time of each step as an array sorted by largest total time first' do
      @parser.step_part_of_total.should == [4, 0.5]
    end
  end
end