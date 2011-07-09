# Singleton Pattern
#
# GoF -a class that can only have one instance and that
# provides global access to that one instance
# let the class of a singleton object manage the creation
# and access to its sole instance
#

# class variable: @@var_name
# class methods:  self refers to the class outside of a method defintion
#def self.some_class_method end

# steps: create a class var for the instance, class method to access it,
# make new private (private_class_method :new)

# note: ruby is an open language so anything that is done can be un-done
# at runtime.  Ruby is an open language, it is up to you to do the right
# things.  you are in the drivers seat, not the language.

class SomeLogger
  @@instance = SomeLogger.new
  def self.instance
    return @@instance
  end

  private_class_method :new
end

# uses lazy instantiation
require 'singleton'

class SomeLogger
  include Singleton
end

# also, you can create the class as a singleton, where
# each method call makes reference to the singleton e.g.:

def self.error(msg)
  @@log.puts(msg)
  @@log.flush
end

# module as a singleton
# modules and classes are similiar, but you can 'new' a module
module ModuleLogger
  ERROR = 1
  INFO = 2

  @@log = File.open('log.txt', 'w')
  @@level = INFO

  def self.error(msg)
    @@log.puts(msg)
    @@log.flush
  end
end

