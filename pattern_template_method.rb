# Template Method pattern
# vary an algorithm by seperating the invariant part in a base class, and encapsulate the variable
# parts in subclasses

class Report
  def initialize
    @title = 'Monthly Report'
    @text = ['Things are going', 'really, really well!']
  end

  def output_report
    output_start
    output_header
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_start
  end

  def output_header
  end

  def output_body_start
  end

  def output_line(line)
  end

  def output_body_end
  end

  def output_end
  end

end #Report


class HTMLReport < Report
  def output_start
    puts ('<html>')	  
  end

  def output_header
    puts('<head>')
    puts(" <title>#{@title}</title>")
    puts('</head>')
  end

  def output_line(line)
    puts(" <p>#{line}</p>")
  end

  def output_body_end
    puts('</body>')
  end

  def output_end
    puts('</html>')
  end

end # HTMLReport


report = HTMLReport.new
report.output_report
