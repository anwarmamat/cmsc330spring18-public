#### Regular Expressions

# Takes a string and returns true if the string represents a decimal
# and false otherwise
# Valid examples: “+1.0”, “+1”, “-124.124”, “1”, “-1”
# Invalid examples: “1,000.0”, “1.1.1”
def is_decimal(str)

end

# Takes a string and returns an array of all valid decimal numbers
# in the string
def find_all_decimals(str)

end

# Takes a string that is a comma delineated list of names, and returns
# an array with all of the names from the input that are formatted correctly
# Names must start with a capital letter, have all other letters be lowercase,
# and include no extraneous characters.
# Ex: check_names("Damien,aDam,0Daniel,Jake,GREG") => ["Damien","Jake"]
def check_names(str)

end

#### Non-Regex Challenge Problem

# For the following function, a two element array [x, y] can be
# treated as an graph edge, from x to y. So a graph defined as
# [[1,2],[2,3],[4,3],[4,1]] would look like this:
#
#       4 -> 3
#(down) |    | (up)
#       1 -> 2
#
# and reachable([[1,2],[2,3],[4,3],[4,1]], 1, 2) would return true
# but reachable([[1,2],[2,3],[4,3],[4,1]], 1, 4) would return false
#
# Takes a list of edges and two vertices, a and b, and returns
# a boolean indicating whether there is a path between a and b.
def reachable(graph, v1, v2)

end
