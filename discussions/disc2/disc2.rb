# Discussion 2 problems

# Array problems
# https://ruby-doc.org/core-trunk/Array.html

# Takes an Array arr, where the elements are Integers, and returns a new Array
# which has the even elements of arr.
#
# e.g. evens([1, 2, 3, 4]) -> [2, 4]
def evens(arr)

end

# Takes an Array arr and returns a new Array which has the elements of arr
# except the elements which are equal to old are replaced with rep.
#
# e.g. replace_all([1, 2, 3, 1], 1, 3) -> [3, 2, 3, 3]
def replace_all(arr, old, rep)

end

# Hash problems
# https://ruby-doc.org/core-trunk/Hash.html

# Takes a Hash, where the keys and values are Integers, and returns a new
# Array which has each key multipled by its associated value.
# (Order doesn't matter.)
#
# e.g. mult_vals({1 => 2, 3 => 4}) -> [2, 12]
def mult_vals(hash)

end

# Takes a Hash which is a counter, where the keys are mapped to their counts,
# and returns an Array which contains each key repeated based on their counts.
# (Order doesn't matter.)
#
# e.g. counter_to_array({"alice" => 2, "bob" => 3}) ->
#   ["alice", "alice", "bob", "bob", "bob"]
def counter_to_array(counter)

end

# Yield problems

# Takes 2 Arrays (arr1 and arr2) of equal length and a code block with 2
# arguments. Returns a new Array where the ith element is the return value of
# the code block called on the ith elements of arr1 and arr2.
#
# e.g. map2([1, 2], [3, 4]) { |a, b| a * b } -> [3, 8]
def map2(arr1, arr2)

end

# Takes an Array arr and a code block with 1 argument. Returns an Array of 2
# Arrays, which represents a partition of arr. The 1st Array has the elements
# of arr for which the code block called on the element returns a truthy
# value. The 2nd Array has the other elements.
#
# e.g. partition([1, 2, 3, 4]) { |e| e.even? } -> [[2, 4], [1, 3]]
def partition(arr)

end

# Regular Expressions functions
# https://ruby-doc.org/core-trunk/doc/regexp_rdoc.html

# Takes a String str. See this format:
#
# name: Firstname Lastname id: 123456789
# * where "Firstname" and "Lastname" can be any string which starts with an
#   uppercase letter and has 0 or more lowercase letters afterwards.
# * where "123456789" can be any string of exactly 9 digits.
# * where everything else has to be exactly the same.
#
# If str has this format, then return a Hash with 2 key-value pairs: The 1st
# is :name mapped to the student's name (e.g. "Firstname Lastname") and the
# 2nd is :id mapped to the student's ID (e.g. "123456789").
#
# If str doesn't have this format, return :error.
#
# e.g.
# extract_student_data("name: Anwar Mamat, id: 000000000") ->
#   { :name => "Anwar Mamat", :id => "000000000" }
# extract_student_data("Nom: Anwar Mamat, ID: 123") ->
#   :error
def extract_student_data(str)

end

# Takes a String str and returns an Array which has all the "names" in str,
# where a "name" is a string which starts with an uppercase letter and has 0
# or more lowercase letters afterwards.
#
# e.g. scan_names("AliceBob!!!Carol david) -> ["Alice", "Bob", "Carol"]
def scan_names(str)

end

