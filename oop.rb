class User
  def name
    @name
  end
  def name=(value)
    @name = value
  end
end

class User
  attr :name, true
  attr :age
end

class User
  attr_reader :r1, :r2 #read-only
  attr_writer :w1, :w2 #write-only
  attr_accessor :a1, :a2 #r&w
end

class User
  attr_accessor :age, :user_name, :salary

  def initialize(&block)
    instance_eval &block
  end
end

u = User.new do
  self.user_name = "..."
  self.age = 50
end

# class vars

class User
  @@user_count = 0

  def self.user_count=(x)
    @@user_count = x
  end
  def self.user_count
    @@user_count
  end

end

class SomeClass
  MY_CONST = "a"	# class constant

  @@var = "b"		# class var
  @var = "c"		# class inst var

  def initialize
    @var = "d"		# inst var
  end

  def my_method
    puts MY_CONST	# class constant
    puts @@var		# class var
    puts @var		# inst var
  end

  def self.class_method1
    puts MY_CONST	# class constant
    puts @@var		# class var
    puts @var		# class inst var
  end

end #class

def SomeCLass.class_method2
  puts SomeClass::MY_CONST
  # puts @@var
  puts @var
end

s = SomeClass.new
SomeClass.class_method1   #a b c
SomeClass.class_method2   #a c
s.my_method		  #a b, d

# inheriting
# superclass, subclass

class User
  attr_accessor :name, :age

  def initialize(name, age)
    @name, @age = name, age
  end
end

class Student < Age
  attr_accessor :gpa, :hours

  def initialize(name, age, gpa, hours)
    super(name, age)
    @gpa, @hours = gpa, hours
  end
end

# student is-a user

# introspection
s = "hello"
s.class #string
a = 100
a.class #fixnum

# Class is an object, and Object is a class

10.instance_of? Fixnum	#true
"hello".instance_of? String #true

n = 1234234234
n.instance_of? Bignum 	#true
n.kind_of? Bignum 	#true
n.is_a? Bignum		#true

# duck typing
blah.respond_to?(:some_method)
blah.respond_to?(:some_private_method, true)

# parent
my_obj.superclass

# equality





