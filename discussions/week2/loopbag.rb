#
# Loopbag Class
# CMSC330 Fall 2017
#

# Flight recorders aka black boxes record the last two hours
# of sound on a plane, as well as other information.
# They use a continuous loop of tape that completes
# a cycle every 2 hours. As new material is recorded,
# the oldest material is replaced. In this example, you will
# implement a Loopbag, which is a fixed size container and
# works like a flight recorder. The size of the bag is given
# the when the Loopbag object is created. After the Loopbag is
# full, if a new item is inserted, the oldest item in the Loopbag
# is replaced. You will implement the following methods:

class Loopbag
  def initialize(s)
    @capacity = s
    @a=[]
  end

# Adds the given item to LoopBag.
  def insert(item)




  end

# Returns the number of items in this LoopBag
  def size


  end
#Returns true if this LoopBag is empty and false otherwise
  def empty?



  end



#return true if bag contains the item. false otherwise
  def contains?(item)




  end
# union method creates the union with the given LoopBag

# Example:
#    bag1 = Loopbag.new(5)
# Assume bag1 has items 1,2,3,4 and bag2 has items 3,4,5,6,
# then bag1.union(bag2) updates bag1 such that now, bag1 has 2,3,4,5,6
  def union(lb)





  end

# each method takes a code block and yields each member of a collection to it in turn.
# You have to iterate over the elements in FIFO order.

# Example:
#   bag = Loopbag.new(5)
#   bag.insert(1);
#   bag.insert(2);
#   bag.insert(3);
#   bag.insert(4);
#   bag.insert(5);
#   bag.insert(6);
#   bag.insert(7);
#   bag.each{|x| print "#{x},"}
# Output: 3,4,5,6,7,

  def each







  end

end
