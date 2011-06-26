# Composite Pattern
# build bigger objects from small sub-objects (which may be build from sub-sub-objects)
# GoF - the sum acts like one of the parts
# use case: building a hierarchy/tree of objects, and don't want to worry
#           about if you are dealing with a single object or many
# impl =>  1. common interface/base class of all objects (the component)
#          2. leaf classes - impl. the component interface #1
#          3. composite class - high level obj. build from subcomponents
# in the wild: GUI objects
class Task
  attr_reader :name, :parent
  
  def initialize(name)
    @name = name
    @parent = nil
  end
  
  def get_time_required
    0.0
  end
end

class CompositeTask < Task
  
  def initialize(name)
    super(name)
    @sub_tasks = []
  end
  
  def [](index)
    @sub_tasks[index]
  end
  
  # object[i] = value
  def []=(index, new_value)
    @sub_tasks[index] = new_value
  end
  
  def <<(task)
    @sub_tasks << task
    task.parent = self
  end
  
  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end
  
  def get_time_required
    time = 0.0
    @sub_tasks.each {|task| time += task.get_time_required}
    time
  end
  
  def total_number_basic_tasks
    total = 0.0
    @sub_tasks.each {|task| total += task.total_number_basic_tasks}
    total
  end
end

class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingrediants')
  end
  
  def get_time_required
    1.0
  end
end

class MixTask < Task
  def initialize
    super('Mix the batter')
  end
  
  def get_time_required
    3.0
  end
end

class MakeCakeTask < CompositeTask
  def initialize
    super('Make batter')
    @sub_tasks = []
    add_sub_task( AddDryIngredientsTask.new )
    add_sub_task( AddLiquidsTask.new )
    add_sub_task( MixTask.new )
  end
  
  
  
end