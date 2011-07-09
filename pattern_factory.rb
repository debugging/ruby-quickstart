# Factory Pattern
# GoF:  technique of pushing the 'which class' problem down
# to the subclass
# creators: the base and concrete classes that contain the factory methods
# products: the objects being created
#
# Factory Method applies tmeplate method to object creation
#
#
# example: pond, creator is the pond, creators the specific types of ponds (duckpond
# or frogpond).  products are the duck and frog classes
#
#

# parameterized factory method
class Pond
  def initialize(number_animals, number_plans)
  @animals = []
  number_animals.times do |i|
    animal = new_organism(:animal, "Animal#{i}")
    @animals << animal
  end

  @plants = []
  number_plants.times do |i|
    plant = new_organism(:plant, "Plant#{i}")
    @plants << plant
  end
end

# if we need to create a new subclass for each specific type of object
# like DuckWaterLilyPond, FrogAlgaePond, etc., this could get out of hand

# abstract factory - an object dedicated to creating compatible sets of objects

class PondOrganismFactory
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

class JungleOrganismFactory
  def new_animal(name)
    Tiger.new(name)
  end

  def new_plant(name)
    Tree.new(name)
  end
end

class Habitat
  def initialize(number_animals, number_plants, organism_factory)
    @organism_factory = organism_factory

    @animals = []
    number_animals.times do |i|
      animal = @organism_factory.new_animal("Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = @organism_factory.new_plant("Plant#{i}")
      @plants << plant
    end
  end

  # ...
end

jungle = Habitat.new(1, 4, JungleOrganismFactory.new)
junle.simulate_one_day

pond = Habitat.new(2, 4, PondOrganismFactory.new)
pond.simulate_one_day

# UML of abstract factory
# AbstractFactory(create_product1, create_product2)
#   ConcreateFactoryA(create_product1, create_product2)
#     ProductA1
#     ProductA2
#   ConcreteFactoryB(create_product1, create_product2)
#     ProductB1
#     ProductB2
#
# Abstract Factory: problem is you need to create a set of compatible objects,
# solution is you write a seperate class to handle creation.
# Abstract factory is simply the strategy pattern applied to the situation
# knows how to create several different types of objects
#
# Classes are just objects - instead of having different abstract factory classes, one
# class for each set of things the factory needs to produce, we can have just one
# factory that stores the class of objects it needs to produce
#
class OrganismFactory
  def initialize(plant_class, animal_class)
    @plant_class = plant_class
    @animal_class = animal_class
  end
  def new_animal(name)
    @animal_class.new(name)
  end
  def new_plant(name)
    @plant_class.new(name)
  end
end
jungle_organism_factory = OrganismFactory.new(Tree, Tiger)
pond_organism_factory = OrganismFactory.new(WaterLily, Frog)

jungle = Habitat.new(1, 4, jungle_organism_factory)
jungle.simulate_one_day

pond = Habitat.new(2, 4, pond_organism_factory)
pond.simulate_one_day

# leveraging the name
# scenerio: produce abstract factory for objects with consistant naming
# convention

class IOFactory
  def initialize(format) 
    @reader_class = self.class.const_get("#{format}Reader")
    @writer_class = self.class.const_get("#{format}Writer")
  end
  
  def new_reader
    @reader_class.new
  end

  def new_writer
    @writer_class.new
  end
end

html_factory = IOFactory.new('HTML')
html_reader = html_factory.new_reader

pdf_factory = IOFactory.new('PDF')
pdf_writer = pdf_factory.new_writer

# Active record uses this technique:
def self.mysql_connection end
def self.oracle_connection end

adapter = "mysql"
method_name = "#{adapter}_connection"
Base.send(method_name, config)

