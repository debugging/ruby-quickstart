# Decorator Pattern
# easily add enhancements to an existing object
# layer features atop one another to construct exactly what you need
# layer features on to a basic object
#
# drawbacks: using or building/assembling all these classes into a working w# whole i.e. client has to pull of the pieces together
# also, performance overhead of long chain of decorators
#
# scenerio: need a class to write out lines to a file
# some lines might need to be numbered, others with timestampls, and
# yet another with checksum values
# or maybe lines with a combination of the above
# we could create 1 class with all these seperate methods
# or use inheritance to create seperate classes for each output type
# but then # of classes can get out of hand, and you need to know
# at design time of all these combinations

# solution:  assemble the combination of features dynamically at runtime

def SimpleWriter
  def initialize(path)
	  @file = File.open(path, 'w')
  end
  def write_line(line)
	  @file.print(line)
	  @file.print("\n")
  end
  def pos
	  @file.pos
  end
  def rewind
	  @file.rewind
  end
  def close
	  @file.close
  end
end

# factor out generic code to base class
class WriterDecorator
	def initialize(real_writer)
		@real_writer = real_writer
	end
	
	def write_line(line)
		@real_writer.write_line(line)
	end

	def pos
		@real_writer.pos
	end

	def rewind
		@real_writer.rewind
	end

	def close
		@real_writer.close
	end
end

class NumberingWriter < WriterDecorator
	def initialize(real_writer)
		super(real_writer)
		@line_number = 1
	end

	def writer_line(line)
		@real_writer.write_line("#{@line_number}: #{line}")
	end

end

writer = NumberingWriter.new(SimpleWriter.new('final.txt'))
writer.write_line("some text here")

writer = CheckSummingWriter.new(TimeStampingWriter.new(
	    NumberingWriter.new(SimpleWriter.new('blah.txt'))))
writer.write_line('some text ehre')

# easing delegation using forwadable
# could also use aliasing to wrap old method with implementaiton e.g. adding
# timestamp then calling original method
# Modules: create modules, using extend for each 'decoration'
