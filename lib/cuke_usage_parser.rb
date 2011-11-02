class CukeUsageParser
  @results

  def initialize filename
    @results = []
    index = 0
    fastest = nil
    slowest = nil
    occurrence = 0
    skipping = true
    done = false

    File.readlines("#{filename}").each do |line|
      next if line.nil?

      #stop processing once we have finish the import
      break if line == "\n" and not skipping

      #skip past lines until we get to what is probably our first line
      skipping = false if line["#"]
      next if skipping

      
      if is_definition? line
        unless @results[index].nil?
          @results[index]["fastest"] = fastest
          @results[index]["slowest"] = slowest
          @results[index]["occurances"] = occurrence
          @results[index]["total"] = @results[index]["average"] * occurrence
        end

        #next definition
        index = index + 1
        fastest = nil
        slowest = nil
        occurrence = 0
        duration = elapsed line

        @results[index] = Hash.new
        @results[index]["name"] = step_name line
        @results[index]["average"] = duration
        @results[index]["source"] = source line
      else
        unless line["NOT MATCHED BY ANY STEPS"]
          occurrence = occurrence + 1
          duration = elapsed line

          slowest = duration if slowest.nil? or duration > slowest
          fastest = duration if fastest.nil? or duration < fastest
        end
      end
    end

    #our last step may not get calculations performed on it
    @results[index]["fastest"] = fastest
    @results[index]["slowest"] = slowest
    @results[index]["occurances"] = occurrence
    @results[index]["total"] = @results[index]["average"] * occurrence

    @results.compact!
  end

  def all
    @results
  end

  def used_steps
    @results.select {|r| r["occurances"] > 0 }
  end

  def unused_steps
    @results.select {|r| r["occurances"] == 0 }
  end

  def highest_average
    used_steps.sort {|a,b| a["average"] <=> b["average"]}.last
  end

  def highest_elapsed_time
    used_steps.sort {|a,b| a["total"] <=> b["total"]}.last
  end

  def total_elapsed_time
    total = 0

    used_steps.each do |result|
      next if result.nil?
      next if result["total"].nil?

      total = total + result["total"]
    end

    total
  end

  def greatest_variation
    used_steps.sort {|a,b| (a["fastest"] - a["slowest"]) <=> (b["fastest"] - b["slowest"])}.first
  end

  def total_times_plot_data
    used_steps.map {|r| r["total"]}
  end

  def average_times_plot_data
    used_steps.map {|r| r["average"]}
  end

  def step_part_of_total
    used_steps.map {|r| r["total"]}.sort.reverse
  end

  private
  def is_definition? line
    line.match(/^\s\s/).nil?
  end

  def elapsed line
    line.strip!
    line.split(" ").first.to_f
  end

  def step_name line
    line.strip!
    name = line.split("/")[1]

    "/#{name}/"
  end

  def source line
    src = line.split("#").last
    src.strip! unless src.nil?
  end
end