# Kernal, Object, and Module

# reflection - examine state and structure
# metaprogramming - programs that write programs


# types, classes, modules
o.class
o.superclass
o.instance_of? c
o.is_a? c
o.kind_of? c # same as is_a?
c === c # o.is_a? c
o.respond_to? name

# ancestry
C < B 		# c includes B
Fixnum < Integer # true, all fixnums are integers
A.ancestors
String.ancestors	# [String, Enumerable, Comparable, Object, Kernal]
C.include? B

A.included_modules

# extends an object by making the instance methods of
# of the module into singleton methods of the object
object.extend(SomeModule)	# add to singleton method
Class.extend(SomeModule)	# add class methods

Module.nesting

# classes and modules are instances of Class and Module
M = Module.new
C = Class.new
D = Class.new(C) {
  include M
}
D.to_s	# "D"


# Evaluating
x = 5
eval "x + 1"   # 6

# bindings

# Object#instance_eval and Module#class_eval a.k.a module_eval

o.instance_eval("@x")
String.class_eval("def len; size; end")
String.class_eval("alias len size")

# instance_eval defines singleton methods of the object (results in class methods when it is called on a class object)
# class_eval defines instance methods

#1.9, only accept blocks.  also accept arguments
instance_exec
class_exec # a.k.a module_exec 

# variables and constants
global_variables
local_variables

SomeClass:instance_variables
SomeClass::constants

# querying/setting/testing vars
eval(var_name)
eval("var_name = '$g'")
eval("#{var_name} = x")

# new variables created using eval exist only for that invocation

o = Object.new
o.instance_variable_set(:@x, 5)
o.instance_variable_get(:@x)
o.instance_variable_defined?(:@x)

Object.class_variable_set/get/defined? (:@@x)

Object.const_set/get/defined? (:BLAH, value)


#1.8, querying/setting variables are private, use class_eval to set etc.
String.class_eval { class_variable_set(:@@x, 1)  }

o.instance_eval { remove_instance_variable(:@x) }
String.const_eval { remove_class_variable(:@@x) }
String.send :remove_const, :BLAH #with send you can invoke priv methods

# const_missing method invoked if referring to undefined constant
def SomeModule.const_missing(name)
  name
end

# Methods
# return strings in 1.8, symbols in 1.9
# Object defines methods for listing methods
o.methods
o.public_methods
o.public_methods(false) # excludes inherited methods
o.protected_methods
o.private_methods
o.private_methods(false) # excludes inherited priv methods
o.singleton_methods

# module methods for a class for listing class level 
String.instance_methods
String.instance_methods(false)
String.public_instance_methods
String.protected_instance_methods
String.private_instance_methods(false)


Math.singleton_methods

String.public_method_defined?
String.protected_method_defined?
String.private_method_defined?
String.method_defined?


# method objects
"s".method(:reverse)

#invoking or 'sending a message to an object'
"hello".send :upcase
#1.9
"hello".public_send :upcase
# __send__ is defined as a synonym


# defining, undefining, and aliasing methods
# define_method is private, must be called inside class/module 

# add instance method
def add_method(c, m, &b)
  c.class_eval {
    define_method(m, &b)  #takes module object or block
  }
end

# add class method, must use define_method on eigenclass/singleton
def add_class_method(c, m, &b)
  eignclass = class << c; self; end
  eignclass.class_eval {
    define_method(m, &b)
  }
end

String.define_singleton_method(:blah)  { ... }  # 1.9 only


alias plus +  # plus is a synonym for +


Module.remove_method # removes from current class
undef_method # removes from current and inherited

#freeze prevents alterations of class

# method_missing => handling undefined mehods
# Kernel#method_missing throws NoMethodError exception

# method visibility
# prublic, protocted, private are private instance methods from Module

