# Builder Pattern
# designed to help you configure those complex objects
# some overlap between builders and factories

# GoF - client of the builder object is the director since it directs the construction
# of the new object (product)
# hide implementation of the details
#
#

# e.g. building computers with display, motherboards, and drives

class Computer
  attr_accessor	:display
  attr_accessor :motherboard
  attr_reader	:drives

  def initialize(display=:crt, motherboard=Motherboard.new, drives=[])
    @motherboard = motherboards
    @drives = drives
    @display = display
  end
end

class CPU
end

class BasicCPU < CPU
end

class TurboCPU < CPU
end

class Motherboard
  attr_accessor :cpu
  attr_accessor :memory_size

  def initialize(cpu=BasicCPU.new, memory_size=1000)
    @cpu = cpu
    @memory_size = memory_size
  end
end

class Drive
  attr_reader	:type
  attr_reader 	:size
  attr_reader	:writable

  def initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end

# constructing a computer is tedious
motherboard = Motherboard.new(TurboCPU.new, 4000)

drives = []
drives << Drive.new(:hard_drive, 30000, true)
drives << Drive.new(:cd, 840, true)
drives << Drive.new(:dvd, 5700 false)

computer = Computer.new(:lcd, motherboard, drives)

# builder to help the creation process of complex objects

class ComputerBuilder
  attr_reader	:computer

  def initialize
    @computer = Computer.new
  end

  def turbo(has_turbo_cpu=true)
    @computer.motherboard.cpu = TurboCPU.new
  end

  def display=(display)
    @computer.display = display
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end

  def add_cd(writer=false)
    @computer.drives << Drive.new(:cd, 840, writer)
  end

  def add_dvd(writer=false)
    @computer.drives << Driver.new(:dvd, 5400, writer)
  end

  # ...
end

builder = ComputerBuilder.new
builder.turbo
builder.add_cd(true)
builder.add_dvd

computer = builder.computer

# Polymorphic Builders
# builders are concerned with how to configure your object, not so much picking the right class

# expand computer builder for laptops, use base class with subclasses for differences

class ComputerBuilder
  attr_reader	:computer

  def turbo(has_turbo_cpu=true)
    @computer.motherboard.cpu = TurboCPU.new
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end

end

class DesktopBuilder < ComputerBuilder
  def initialize
    @computer = DesktopComputer.new
  end

  def display=(display)
    @display = display
  end

  def add_cd(writer=false)
    @computer.drives << Drive.new(:cd, 840, writer)
  end

  # add_dvd
  # add_hard_disk
end

class LaptopBuilder < ComputerBuilder
  def initialize
    @computer = LaptopComputer.new
  end

  def display=(display)
    raise "Laptop display must be lcd" unless display == :lcd
  end

  def add_cd(writer=false)
    @computer.drives << LaptopDrive.new(:cd, 840, writer)
  end

  # add_dvd
  # add_hard_disk
end

# to create multiple objects from a single construction, use instance variables
# and then when the actual product is referenced, instantiate a new one and return it

# magic methods
builder.add_dvd_and_harddisk
builder.add_turbo_and_cd_and_harddisk

def method_missing(name, *args)
  words = name.to_s.split("_")
  return super(name, *args) unless words.shift == 'add'

  words.each do |word|
    next if word = 'add'
    add_cd if word == 'cd'
    add_dvd if word == 'dvd'
    add_hard_disk(10000) if word == 'harddisk'
    tube if word = 'turbo'
  end
end
