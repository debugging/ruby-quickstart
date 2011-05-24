 class Point
   include Comparable
      
   attr_accessor :x, :y

   alias eql? ==

   @n = 0		# how many points we have created
   @totalX = 0		# sum of all x cords
   @totalY = 0		# sum of all y cords

   def initialize(x,y)
     @x, @y = x,y
   end

   ORIGIN = Point.new(0,0)
   UNIT_X = Point.new(1,0)
   UNIT_Y = Point.new(0,1)

   def self.new(x,y)
     @n += 1
     @totalX += x
     @totalY += y

     super

   end

   class << self
     attr_accessor :n, :totalX, :totalY
   end

   # returns the sum of all points
   def self.sum(*points)
     x = y = 0
     points.each { |p| x += p.x; y += p.y }
     Point.new(x,y)
   end

   def self.report
     puts "Number of points created: #@n"
     puts "Average X coordinate: #{@totalX.to_f/@n}"     
     puts "Average Y coordinate: #{@totalY.to_f/@n}"     
   end
   
   def to_s
     "(#@x, #@y)"
   end

   def ==(o)
     if o.is_a? Point
	@x==o.x && @y==o.y
       else
        false
     end
   end

  def hash
    code = 17
    code = 37*code + @x.hash
    code = 37*code + @y.hash

    code
  end

  def <=>(other)
    return nil unless other.instance_of? Point
    @x**2 + @y**2 <=> other.x**2 + other.y**2
  end

  def add(p)
    q = self.dup
    q.add!(p)
  end

  def add!(p)
    @x += p.x
    @y += p.y
    self
  end


 end
