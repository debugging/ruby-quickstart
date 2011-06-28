# Adapter Pattern

# bridging the gap between mismatching interfaces
# an adapter is an object that crosses the chasm between the interface
# that you have and the interface that you need

# client -> target  <- adapter <- adaptee

class TextObject
  attr_reader :text, :size_in_inches, :color
  
  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end    

class BritishTextObject
  attr_reader :string, :size_mm, :colour
  
  # ..
end

# build adapater to match textobject interface

class BritishTextObjectAdapter < TextObject
  def initialize(bto)
    @bto = bto
  end
  
  def text
    @bto.string
  end
  
  def size_inches
    @bto.size_mm / 25.4
  end
  
  def color
    @bto.colour
  end
end

# or re-open existing object

class BritishTextObject
  def colour
    colour
  end
  def text
    string
  end
  def size_inchces
    size_mm / 25.4
  end
end

# or modify the singleton object and not the class
# ruby looks here first during method lookup
class << bto
  def color
    colour
  end
  
  # ...
end