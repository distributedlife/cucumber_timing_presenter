require 'spec_helper'

module CucumberTimingPresenter
  describe Configuration do

    before do
      Configuration.clean_tmp_dir
    end

    it 'should auto create tmp_dir' do

      tmp_dir = Configuration.tmp_dir
      Dir.exists?(tmp_dir).should == true

      Dir.delete tmp_dir
      tmp_dir = Configuration.tmp_dir
      Dir.exists?(tmp_dir).should == true
    end
  end
end