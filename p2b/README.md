# Project 2B: OCaml Higher Order Functions and Data

CMSC 330, Spring 2018

Due Monday, February 26th 2018 (Late Deadline: Tuesday, Ferbuary 27th)

The Public/Release/Secret breakdown for this project is 65/35/0

Note: The secret tests are worth 0 points, but check that you did not use any features that were not allowed. You will **lose** points if you fail these tests. 

Ground Rules and Extra Info
---------------------------
**This is an individual assignment. You must work on this project alone.**

In your code, you may **only** use library functions found in the [`Pervasives` module][pervasives doc] and the functions provided in `funs.ml`. You **may** use the `@` operator. You **cannot** use the `List` module. You **may not** use any imperative structures of OCaml such as references.

You will lose points for using any of the above that are not allowed. 

At a few points in this project, you will need to raise an `Invalid_argument` exception. Use the `invalid_arg` function to do so:
```
invalid_arg "something went wrong"
```
Note: Use the error message that the function specifies as the argument. 

Introduction
------------
The goal of this project is to increase your familiarity with programming in OCaml and give you practie using higher order functions and user-defined types. You will have to write a number of small functions, the specifications of which are given below. Some of them start out as code we provide you. In our reference solution, each function typically requires writing or modifying 1-8 lines of code, except for the last function, `reachable`, which is more involved.

You should be able to complete Part 1 after the lecture on high-order functions and the remaining sections after the lecture on user-defined types.

Project Files
-------------
To begin this project, you will need to commit any uncommitted changes to your local branch and pull updates from the git repository. [Click here for directions on working with the Git repository.][git instructions] The following are the relevant files:

-  OCaml Files
  - **data.ml**: This is where you will write your code for parts 2-4 of the project.
  - **data.mli**: This file is used to describe the signature of all the functions in the Data module. Don't worry about this file, but make sure it exists or your code will not compile. It also contains our type definitions.
  - **higher.ml**: This is where you will write your code for part 1 of the project.
  - **higher.mli**: This file is used to describe the signature of all the functions in the Higher module. Don't worry about this file, but make sure it exists or your code will not compile.
  - **funs.ml** and **funs.mli**: These files contain definitions for map, fold, length, rev, and fold_right.
  - **public.ml**: This file contains all of the public test cases.
- Submission Scripts and Other Files
  - **submit.rb**: Execute this script to submit your project to the submit server.
  - **submit.jar** and **.submit**: Don't worry about these files, but make sure you have them.
  - **Makefile**: This is used to build the public tests by simply running the command `make`, just as in 216.

Compilation and Tests
---------------------
In order to compile your project, simply run the `make` command and our `Makefile` will handle the compilation process for you, just as in 216. After compiling your code, the public tests can be run by running `public.native` (i.e. `./public.native`; think of this just like with a.out in C)

Part 1: High Order Functions
------------------------
Write the following functions in `higher.ml` using `map`, `fold`, or `fold_right` as defined in the file `funs.ml`. You **must** use `map`, `fold`, or `fold_right` to complete these functions, so no functions in `higher.ml` should be defined using the `rec` keyword. You will lose points if this rule is not followed. Use the other provided functions in `funs.ml` to make completing the functions easier. 

Some of these functions will require just map or fold, but some will require a combination of the two. The map/reduce design pattern may come in handy: Map over a list to convert it to a new list which you then process a second time using fold. The idea is that you first process the list using map, and then reduce the resulting list using fold.

#### is_over_x x lst
- **Type**: `'a -> 'a list -> bool list`
- **Description**: Returns a list of booleans where the value indicates whether the element of `lst` at that index was strictly greater than `x` (according to the > operator).
- **Examples:**
```
is_over_x 0 [1;3;1] = [true;true;true]
is_over_x "z" [] = []
is_over_x "bob" ["alive";"bat";"bob";"zebra"] = [false; false; false; true]
```

#### count_over_x x lst
- **Type**: `'a -> 'a list -> int`
- **Description**: Returns how many elements in `lst` are strictly greater than `x`.
- **Examples:**
```
count_over_x 0 [1;3;1] = 3
count_over_x "z" [] = 0
count_over_x "bob" ["alive";"bat";"bob";"zebra"] = 1
```

#### mean lst
- **Type**: `float list -> float`
- **Description**: Returns the mean of elements in `lst`. If the list is empty raise Invalid_argument with the string "mean".
- **Examples:**
```
mean [] = Invalid_argument("mean")
mean [1.0;2.0;3.0] = 2.0
mean [5.0] = 5.0
```

#### pred_succ lst
- **Type**: `int list -> int list`
- **Description**: Returns a list where every elements is replaced with its predecessor, itself, and successor.
- **Examples:**
```
pred_succ [] = []
pred_succ [1] = [0;1;2]
pred_succ [0;5;7] = [-1;0;1;4;5;6;6;7;8]
```

#### bind f lst
- **Type**: `('a -> 'b list) -> 'a list -> 'b list`
- **Description**: Applies the function `f` to all elements in `lst` and then concatenates the results into a single list.
- **Examples:**
```
bind (fun x -> []) [1;2;3;4] = []
bind (fun x -> [(succ x)]) [] = []
bind (fun x -> [x^"?";x^"!"]) ["foo";"bar"] = ["foo?";"foo!";"bar?";"bar!"]
bind (fun x -> [(pred x);(succ x)]) [1;2] = [0;2;1;3]
bind (fun x -> [int_of_float x;(int_of_float x)*2]) [1.0;2.0;3.0] = [1; 2; 2; 4; 3; 6]

```

#### ap fns args
- **Type**: `('a -> 'b) list -> 'a list -> 'b list`
- **Description**: Applies each function in `fns` to each argument in `args` in order.
- **Examples:**
```
ap [] [1;2;3;4] = []
ap [succ] [] = []
ap [(fun x -> x^"?"); (fun x -> x^"!")] ["foo";"bar"] = ["foo?";"bar?";"foo!";"bar!"]
ap [pred;succ] [1;2] = [0;1;2;3]
ap [int_of_float;fun x -> (int_of_float x)*2] [1.0;2.0;3.0] = [1; 2; 3; 2; 4; 6]

```

Note the types of `map`, `ap`, and `bind`. Do you see the similarities?

```
map : ('a -> 'b) -> 'a list -> 'b list
ap : ('a -> 'b) list -> 'a list -> 'b list
bind : ('a -> 'b list) -> 'a list -> 'b list
```

Part 2: Integer BST
--------------------------------
The remaining sections will be implemented in `data.ml`.

Here, you will write functions that will operate on a binary search tree whose nodes contain integers. Provided below is the type of `int_tree`.

```
type int_tree =
    IntLeaf
  | IntNode of int * int_tree * int_tree
```

According to this definition, an ``int_tree`` is either: empty (just a leaf), or a node (containing an integer, left subtree, and right subtree). An empty tree is just a leaf.

```
let empty_int_tree = IntLeaf
```

Like lists, BSTs are immutable. Once created we cannot change it. To insert an element into a tree, create a new tree that is the same as the old, but with the new element added. Let's write `insert` for our `int_tree`. Recall the algorithm for inserting element `x` into a tree:

- *Empty tree?* Return a single-node tree.
- `x` *less than the current node?* Return a tree that has the same content as the present tree but where the left subtree is instead the tree that results from inserting `x` into the original left subtree.
- `x` *already in the tree?* Return the tree unchanged.
- `x` *greater than the current node?* Return a tree that has the same content as the present tree but where the right subtree is instead the tree that results from inserting `x` into the original right subtree.

Here's one implementation:

```
let rec int_insert x t =
  match t with
    IntLeaf -> IntNode (x, IntLeaf, IntLeaf)
  | IntNode (y, l, r) when x < y -> IntNode (y, int_insert x l, r)
  | IntNode (y, l, r) when x = y -> t
  | IntNode (y, l, r) -> IntNode (y, l, int_insert x r)
```

**Note**: The `when` syntax may be unfamiliar to you - it acts as an extra guard in addition to the pattern. For example, `IntNode (y, l, r) when x < y` will only be matched when the tree is an `IntNode` and `x < y`. This serves a similar purpose to having an if statement inside of the general `IntNode` match case, but allows for more readable syntax in many cases.

Let's try writing a function which determines whether a tree contains an element. This follows a similar procedure except we'll be returning a boolean if the element is a member of the tree.

```
let rec int_mem x t =
  match t with
    IntLeaf -> false
  | IntNode (y, l, r) when x < y -> int_mem x l
  | IntNode (y, l, r) when x = y -> true
  | IntNode (y, l, r) -> int_mem x r
```

It's your turn now! Write the following functions which operate on `int_tree`.

#### int_size t
- **Type**: `int_tree -> int`
- **Description**: Returns the number of nodes in tree `t`.
- **Examples:**
```
int_size empty_int_tree = 0
int_size (int_insert 1 (int_insert 2 empty_int_tree)) = 2
```

#### int_min t
- **Type**: `int_tree -> int`
- **Description**: Returns the minimum element in tree `t`. Raises exception `Invalid_argument("int_min")` on an empty tree. This function should be O(height of the tree).
- **Examples:**
```
int_min (int_insert_all [1;2;3] empty_int_tree) = 1
```

#### int_insert_all lst t
- **Type**: `int list -> int_tree -> int_tree`
- **Description**: Returns a tree which is the same as tree `t`, but with all the integers in list `lst` added to it. Try to use fold to implement this in one line.
- **Examples:**
```
int_as_list (int_insert_all [1;2;3] empty_int_tree) = [1;2;3]
```

#### int_as_list t
- **Type**: `int_tree -> int list`
- **Description**: Returns a list where the values correspond to an [in-order traversal][wikipedia inorder traversal] on tree `t`.
- **Examples:**
```
int_as_list (int_insert 2 (int_insert 1 empty_int_tree)) = [1;2]
int_as_list (int_insert 2 (int_insert 2 (int_insert 3 empty_int_tree))) = [2;3]
```

#### int_common t x y
- **Type**: `int_tree -> int -> int -> int`
- **Description**: Returns the closest common ancestor of `x` and `y` in the tree `t` (i.e. the lowest shared parent in the tree). Raises exception `Invalid_argument("int_common")` on an empty tree or where `x` or `y` don't exist in tree `t`.
- **Examples:**
```
let t = int_insert_all [6;1;8;5;10;13;9;4] empty_int_tree;;
int_common t 1 10 = 6
int_common t 8 9 = 8
```

Part 3: Polymorphic BST
---------------------------------
Our type `int_tree` is limited to integer elements. We want to define a binary search tree over *any* totally ordered type. Let's define the type `'a atree` to do so.

```
type 'a atree =
    Leaf
  | Node of 'a * 'a atree * 'a atree
```

This defintion is the same as `int_tree` except it's polymorphic. The nodes may contain any type `'a`, not just integers. Since a tree may contain any value, we need a way to compare values. We define a type for comparison functions.

```
type 'a compfn = 'a -> 'a -> int
```

Any comparison function will take two `'a` values and return an integer. If the integer is negative, the first value is less than the second; if positive, the first value is greater; if 0 they're equal.

Finally, we can bundle the two previous types to create a polymorphic BST.

```
type 'a ptree = 'a compfn * 'a atree
```

An empty tree is just a leaf and some comparison function.

```
let empty_ptree f : 'a ptree = (f, Leaf)
```

You can modify the code from your `int_tree` functions to implement some functions on `ptree`. Remember to use the bundled comparison function!

#### pinsert x t
- **Type**: `'a -> 'a ptree -> 'a ptree`
- **Description**: Returns a tree which is the same as tree `t`, but with `x` added to it.
- **Examples:**
```
let int_comp x y = if x < y then -1 else if x > y then 1 else 0;;
let t0 = empty_ptree int_comp;;
let t1 = pinsert 1 (pinsert 8 (pinsert 5 t0));;
```

#### pmem x t
- **Type**: `'a -> 'a ptree -> bool`
- **Description**: Returns true iff `x` is an element of tree `t`.
- **Examples:**
```
(* see definitions of t0 and t1 above *)
pmem 5 t0 = false
pmem 5 t1 = true
pmem 1 t1 = true
pmem 2 t1 = false
```

Part 4: Graphs with Records
--------------------------------------
For the last part of this project, you will implement functions which operate on graphs.

Here are the types for graphs. They use OCaml's record syntax.

```
type node = int
type edge = { src: node; dst: node; }
type graph = { nodes: int_tree; edges: edge list }
```

A graph is record with two fields: a set of nodes aptly called "nodes" (represented as an `int_tree`), and a list of edges. A node is represented as an integer, and an edge is a record identifying its source and destination nodes.

An empty graph has no nodes (i.e., the empty integer tree) and has no edges (the empty list).

```
let empty_graph = { nodes = empty_int_tree; edges = [] }
```

Provided below is a function which adds an edge to a graph. Its type is `edge -> graph -> graph`.

```
let add_edge e { nodes = ns; edges = es } =
  let { src = s; dst = d } = e in
  let ns' = int_insert s ns in
  let ns'' = int_insert d ns' in
  let es' = e::es in
  { nodes = ns''; edges = es' }
```

Given an edge `e` and graph `g`, it returns a new graph that is the same as `g`, but with `e` added. Note this routine makes no attempt to eliminate duplicate edges; these could add some inefficiency, but should not harm correctness.

We also provide a function `add_edges : edge list -> graph -> graph` to add multiple edges at once.

Write the following functions which operate on `graph`.

#### graph_empty g
- **Type**: `graph -> bool`
- **Description**: Returns true iff graph `g` is empty.
- **Examples:**
```
graph_empty (add_edge { src = 1; dst = 2 } empty_graph) = false
graph_empty empty_graph = true
```

#### graph_size g
- **Type**: `graph -> int`
- **Description**: Returns the number of nodes in graph `g`.
- **Examples:**
```
graph_size (add_edge { src = 1; dst = 2 } empty_graph) = 2
graph_size (add_edge { src = 1; dst = 1 } empty_graph) = 1
```

#### is_dst n e
- **Type**: `node -> edge -> bool`
- **Description**: Returns true iff node `n` is the destination of edge `e`.
- **Examples:**
```
is_dst 1 { src = 1; dst = 2 } = false
is_dst 2 { src = 1; dst = 2 } = true
```

#### src_edges n g
- **Type**: `node -> graph -> edge list`
- **Description**: Returns a list of edges in graph `g` whose source node is `n`.
- **Examples:**
```
src_edges 1 (add_edges [{src=1;dst=2}; {src=1;dst=3}; {src=2;dst=2}] empty_graph) = [{src=1;dst=2}; {src=1;dst=3}]
```

#### reachable n g
- **Type**: `node -> graph -> int_tree`
- **Description**: Returns the set of nodes reachable from node `n` in graph `g`, where the set is represented as an `int_tree`. If `n` is neither a source nor a destination in the graph, `IntLeaf` should be returned.
- **Examples:**
```
int_as_list
 (reachable 1
   (add_edges [{src=1;dst=2}; {src=1;dst=3}; {src=2;dst=2}] empty_graph)) =
   [1;2;3]

int_as_list
 (reachable 3
   (add_edges [{src=1;dst=2}; {src=1;dst=3}; {src=2;dst=2}] empty_graph)) =
   [3]

int_as_list
 (reachable 2
   (add_edges [{src=0;dst=1}] empty_graph)) =
   []
```

Project Submission
------------------
You should submit a file `data.ml` and `higher.ml` containing your solution. You may submit other files, but they will be ignored during grading. We will run your solution as individual OUnit tests just as in the provided public test file.

Be sure to follow the project description exactly! Your solution will be graded automatically, so any deviation from the specification will result in lost points.

You can submit your project in two ways:
- Submit your `data.ml` and `higher.ml` directly to the [submit server][submit server] by clicking on the submit link in the column "web submission".
![Where to find the web submission link][web submit link]
Then, use the submit dialog to submit your files directly.
![Where to upload the file][web upload example]
Select your file using the "Browse" button, then press the "Submit project!" button. You **do not** need to put it in a zip file.
- Submit directly by executing a the submission script on a computer with Java and network access. Included in this project are the submission scripts and related files listed under **Project Files**. These files should be in the directory containing your project. From there you can either execute submit.rb or run the command `java -jar submit.jar` directly (this is all submit.rb does).

No matter how you choose to submit your project, make sure that your submission is received by checking the [submit server][submit server] after submitting.

Academic Integrity
------------------
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will be** submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

<!-- Link References -->


<!-- These should always be left alone or at least updated -->
[pervasives doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
[git instructions]: ../git_cheatsheet.md
[wikipedia inorder traversal]: https://en.wikipedia.org/wiki/Tree_traversal#In-order
[submit server]: submit.cs.umd.edu
[web submit link]: image-resources/web_submit.jpg
[web upload example]: image-resources/web_upload.jpg
