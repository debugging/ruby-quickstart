# Command Pattern

# a running list of things to do or undo

# seperates the thought from the deed
# activerecord and migrations use this

# use cases:  
# execute and rollback
# installation wizards, take input from user, then execute queued up commands
# i.e. installer todo-list are commands


# exampe #1
class SlickButton
  attr_accessor :command
  
  def initialize(&block)
    @command = block
  end
  
  def on_button_push
    @command.call if @command
  end
end

new_button = SlickButton.new do
  # ...
end


# example #2
class Command
  attr_reader :description
  
  def initialize(description)
    @description = description
  end
  
  def execute
  end
end

class CreateFile < Command
  def initialize(path, contents)
    super("Create file: #{path}")
    @path = path
    @contents = contents
  end
  
  def execute
    f = File.open(@path, 'w')
    f.write(@contents)
    f.close
  end
end

class DeleteFile < Command
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end
  
  def execute
    File.delete(@path)
  end
end

class CopyFile < Command
  def initialize(source, target)
    super("Copy file: #{path}")
    @source = source
    @target = target
  end
  
  def execute
    FileUtils.copy(@source, @target)
  end
end

#ccmposite to hold commands
class CompositeCommand < Command
  def initialize
    @commands = []
  end
  
  def add_command(cmd)
    @commands << cmd
  end
  
  def execute
    @commands.each {|cmd| cmd.execute}
  end
  
  def description
    description = ''
    @commands.each {|cmd| description += cmd.description + "\n"}
    description
  end
end

cmds = CompositeCommand.new

cmds.add_command(CreateFile.new('file1.txt', "hello world"))
# ...

cmds.execute


# use command pattern to execute a set of commands 
# and use it to rollback
# each command should have .execute and .unexecute (or rollback)




