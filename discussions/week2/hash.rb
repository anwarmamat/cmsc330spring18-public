#### Hash Functions

# Takes a hash and returns an array containing each key in the hash multiplied
# by its value
#
# Ex: mult_vals({1=>2,4=>4}) => [2,16]
def mult_vals(hash)
    hash.map{|key, value|
        key * value
    }
end

# Takes a string and outputs a hash with each unique word
# as a key, and the number of times it occurs as the value
#
# Bonus: modify the skeleton to use regular expressions instead of split
def freq(str)
    arr = str.split(" ")    # splits the string, by spaces, into an array

end

# Takes an array of integers and returns the x^n, where x is the
# most frequently occuring number in the array and n is the number
# of times it occurs
def freq_power(arr)

end

#### Proc Function
# Take an array of integers and return x^2 for each by using Proc.new.
#
# Ex: freq_multi([1,2,3]) => [1,4,9]
#
# (hint: you can pass in power_proc to a function as a code block using
# &power_proc)
def freq_multi(freq_power_proc)
  power_proc = # Create a proc to compute power of two here

  # ...
end
