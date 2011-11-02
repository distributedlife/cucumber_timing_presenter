class CukeUsagePrettyPrinter
  def self.print result
    html = "<table><trbody>"
    result.each do |key, value|
      html = "#{html}<tr><th>#{key}</th><td style='padding-left:0.6em;'><pre>#{value}</pre></td></tr>"
    end
    html = "#{html}</trbody></table>"

    html
  end

  def self.print_all results
    output = ""
    results.each do |result|
      output = "#{output}#{CukeUsagePrettyPrinter.print(result)}<hr/>"
    end

    output
  end
end