#### Regular Expressions

# Takes a string and returns true if the string represents a decimal
# and false otherwise
# Valid examples: “+1.0”, “+1”, “-124.124”, “1”, “-1”
# Invalid examples: “1,000.0”, “1.1.1”
def is_decimal(str)
    return (str =~ /^(-|\+)?\d+(\.\d+)?$/)
end

# Takes a string and returns an array of all valid decimal numbers
# in the string
def find_all_decimals(str)
    # This has nested capture groups.  outermost is what we want and
    # that will appear first
    a = str.scan(/((-|\+)?\d+(\.\d+)?)/)

    a.map {|x| x[0]}
end

# Takes a string that is a comma delineated list of names, and returns
# an array with all of the names from the input that are formatted correctly
# Names must start with a capital letter, have all other letters be lowercase,
# and include no extraneous characters.
# Ex: check_names("Damien,aDam,0Daniel,Jake,GREG") => ["Damien","Jake"]
def check_names(str)
    a = []

    str.split(",").each {|x|
        if x =~ /^[A-Z][a-z]*$/ then a << x end
    }

    a
end

#### Challenge Problem

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
# You MUST use a hash.
def reachable(graph, v1, v2)
    hash = Hash.new {|h,k| h[k] = Array.new }

    graph.each {|x|
        hash[x[0]] << x[1]
    }

    visited = []
    queue = []

    queue = hash[v1]

    while queue.size > 0 do
        v = queue.shift

        if v == v2 then return true end

        visited << v
        hash[v].each {|x|
            if !visited.include?(x) && !queue.include?(x) then
                queue << x
            end
        }
    end

    return false
end
