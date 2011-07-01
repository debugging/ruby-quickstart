# Proxy Pattern
# controlling access, location-independant way of getting object, or 
# delaying its creation => proxy pattern
# - return the client an object that acts like the object they expect
# - the proxy object has a reference to the real object (subject)
#   the proxy forwards the request to the real object
class BankAccount
  attr_reader :balance

  def initialize(starting_balanace=0)
    	@balance = starting_balanace
  end

  def deposit(amount)
	@balance += amount
  end

  def widthdraw(amount)
	@balance -= amount
  end
end

class BankAccountProxy
  def initialize(real_object)
	@real_object = real_object
  end

  def balance
	@real_object.balance
  end

  def deposit(amount)
	@real_object.deposit(amount)
  end

  def withdraw(amount)
	@real_object.withdraw(amount)
  end 
end

# you could add security checks in each call before it 
# passes the call to the real object
# RPC (remote procedure call) creates proxy classes that creates
# a client object that then makes calls out to the real service
# i) remove proxies ii) protection proxies
# iii) virtual proxies - lazy, hold state in client code until the last
# moment when you actually make a call to the real subject
#

# virtual proxy
def VirtualAccountProxy

  def subject
    @subject || (@subject = BankAccount.new(@starting_balanace))
  end
end
# using method missing to minimize the # of methods we have to wrap
# for our proxy class

def method_missing(name, *args)
	@subject.send(name, *args)
end


