# keeping up with the times
# how to tie different parts of your system
# together while keeping tings loosley coupled
# 'Staying informed' 
# GoF - creating an interface between the source of the news
# and the consumers (subject and observers)
# 
# def'n: build components that know about activities of
# other components w/o being tighly coupled

# how to interface between subject and the observer
#   i. pull method
#   ii. push method

# see activerecord => after_create, after_update, after_destroy

module Subject
  def initialize
    @observers = []
  end
  
  def add_observer(observer)
    @observers << observer
  end
  
  def delete_observer(observer)
    @observers.delete(observer)
  end
  
  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

class Employee
  include Subject
  
  attr_reader :name, :title
  attr_writer :salary
  
  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end
  
  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
  
end

require 'observer'
class Employee
  include Observable
  
  attr_reader :name, :title
  attr_writer :salary
  
  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
  end
  
  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
  
end
