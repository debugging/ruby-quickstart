# Strategy pattern
# 'pull the algorithm out into a seperate object'
# delegation based approach to solve what the template method did

# define multiple strategies that support the same interface
# based on composition and delegation
# supply the 'context' to the using class e.g. set strategy in constructor
# decision on selecting strategy is at runtime
# 1) context can be passed to the strategory or
# 2) strategy passed to the context
# for simple cases you can pass code blocks
# that wrap a particular strategy
#
class Report
  attr_reader :title, :text
  attr_accessor :formatter
  
  def initialize(formatter)
    @title = 'Monthly Report'
    @text = ['Things are going', 'really, really well!']
    @formatter = formatter
  end
  
  def output_report
    @formatter.output_report(self)
  end
end

class HTMLFormatter
  def output_report(context)
    puts('<html>')
    puts('  <head>')
    
    puts ("    <title>#{context.title}</title>")
    puts('  </head>')
    puts('  <body>')
    
    context.text.each do |line|
      puts("    <p>#{line}</p>")
    end
    
    puts('  </body>')
    puts('</html>')
  end
end

class PlainTextFormatter
  def output_report(context)
    puts("***** #{context.title} *******")
    context.text.each do |line|
      puts(line)
    end
  end
end

html_format = HTMLFormatter.new
plain_format = PlainTextFormatter.new

report = Report.new(html_format)
report.output_report

report = Report.new(plain_format)
report.output_report
