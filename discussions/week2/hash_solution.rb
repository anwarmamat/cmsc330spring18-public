#### Hash Functions

# Takes a hash and returns an array containing each key in the hash multiplied
# by its value
#
# Ex: mult_vals({1=>2,4=>4}) => [2,16]
def mult_vals(hash)
    a = []

    hash.each {|k,v|
        a << (k * v)
    }

    # This could also be
    # hash.map{|k,v| k * v}

    a
end

# Takes a string and outputs a hash with each unique word
# as a key, and the number of times it occurs as the value
#
# Bonus: modify the skeleton to use regular expressions instead of split
def freq(str)
    arr = str.split(" ")    # splits the string, by spaces, into an array

    # Method 1
    hash = {}

    arr.each {|x|
        if hash[x] then
            hash[x] = hash[x] + 1
        else
            hash[x] = 1
        end
    }

    # Method 2
    #
    # Default value allows us to avoid that conditional
    #
    # hash = Hash.new(0)
    #
    # arr.each {|x|
    #     hash[x] = hash[x] + 1
    # }
    #

    arr
end

# Takes an array of integers and returns the x^n, where x is the
# most frequently occuring number in the array and n is the number
# of times it occurs
def freq_power(arr)
    hash = Hash.new(0)

    arr.each {|x|
        hash[x] = hash[x] + 1
    }

    # Sorting a hash returns an array, so we have to access
    # the value we want. We also need to reverse sort on the
    # second value of each array
    a = hash.sort {|a,b| b[1] - a[1]}
    a[0][0] ** a[0][1]
end

#### Proc Function
# Take an array of integers and return x^2 for each by using Proc.new.
#
# Ex: freq_multi([1,2,3]) => [1,4,9]
#
# (hint: you can pass in power_proc to a function as a code block using
# &power_proc)
def freq_multi(arr)
  power_proc = Proc.new { |n|
     n * n
  }
  arr.map(&power_proc)
end
