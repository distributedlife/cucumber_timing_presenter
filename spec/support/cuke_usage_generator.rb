require 'rubygems'

class CukeUsageGenerator
    @steps

	def initialize
		@steps = Hash.new
	end

	def step_run duration, name, location
		unless @steps[name].nil?
			step = @steps[name]
			step[:count] = step[:count] + 1
			step[:instance] << duration
			step[:total] = step[:total] + duration
		else
			@steps[name] = {:name => name, :total => duration, :count => 1, :instance => [duration], :location => location }
		end
	end	

	def generate file
		@steps.sort { |a,b| a.last[:total] <=> b.last[:total] }.each do |step|
			step = step.last
			file.write  "#{(step[:total] / step[:count])} /^#{step[:name]}$/\t\t\t\t\t # #{step[:location]}\n"

			step[:instance].each { |instance| file.write "  #{instance} #{step[:name]}\t\t\t\t\t # #{step[:location]}\n" }
		end
  end

  def write_to_file filename
    f = File.new filename, "w"
    generate f
    f.flush
    f.close
  end

	def steps
		@steps
	end
end