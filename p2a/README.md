# Project 2A: OCaml Warmup
CMSC 330, Spring 2018

Due Monday, February 19th. (Late Tuesday, 20th)

Public/Release/Secret tests breakdown: 40/30/30

Ground Rules
------------
**This is an individual assignment. You must work on this project alone.**

In your code, you may **only** use library functions found in the [`Pervasives` module][pervasives doc]. This means you **cannot** use the List module or any other module. You may **not** use any imperative structures of OCaml such as references. The `@` operator is **NOT** allowed.

Introduction
------------
The goal of this project is to get you familiar with programming in OCaml. You will have to write a number of small functions, each of which is specified in four sections below.

**This project is due in a little over one week!** We recommend you get started right away, going from top to bottom. The problems get increasingly more challenging, and in many cases later problems can take advantage of earlier solutions.

Project Files
-------------
To begin this project, you will need to pull updates from the git repository. [Click here for directions on working with the Git repository.][git instructions] The following are the relevant files:

- OCaml Files
  - **basics.ml**: This is where you will write your code for all parts of the project.
  - **basics.mli**: This file is used to describe the signature of all the functions in the module. Don't worry about this file, but make sure it exists or your code will not compile.
  - **public.ml**: This file contains all of the public test cases.
- Submission Scripts and Other Files
  - **submit.rb**: Execute this script to submit your project to the submit server.
  - **submit.jar** and **.submit**: Don't worry about these files, but make sure you have them.
  - **Makefile**: This is used to build the public tests by simply running the command `make`, just as in 216.

Notes on P2A and OCaml
----------------------
OCaml is a lot different than languages you're likely used to working with, and we'd like to point out a few quirks here that may help you work your way out of common issues with the language.

- Some parts of this project are additive, meaning your solutions to earlier functions can be used to aid in writing later functions. Think about this in Part 3 and Part 4. 
- Unlike most other languages, = in OCaml is the operator for structural equality whereas == is the operator for physical equality. All functions in this project (and in this class, unless ever specified otherwise) are concerned with *structural* equality.
- The subtraction operator (-) also doubles as the negative symbol for `int`s and `float`s in OCaml. As a result, the parser has trouble identifying the difference between subtraction and a negative number. When writing negative numbers, surround them in parentheses. (i.e. `some_function 5 (-10)` works, but `some_function 5 -10` will give an error)

In order to compile your project, simply run the `make` command and our `Makefile` will handle the compilation process for you, just as in 216. After compiling your code, the public tests can be run by running `public.native` (i.e. `./public.native`; think of this just like with a.out in C)

Part 1: Non-List Functions
------------------------
Implement the following functions that do not require knowledge of lists. The first one requires no recursion and the other two require recursion similar to the discussion 3 exercises. You may assume all integer inputs are non-negative.

#### divides x y
- **Type**: `int -> int -> bool`
- **Description**: Returns `true` iff `x` divides `y`. Formally, x | y iff x ≠ 0 and there exists integer k such that y = xk.
- **Examples:**
```
divides 10 5 = false 
divides 10 20 = true
divides 10 10 = true
divides 10 0 = true
divides 0 15 = false
divides 0 0 = false
```

#### gcd a b
- **Type**: `int -> int -> int`
- **Description**: Returns the greatest common divisor of `a` and `b`. Utilize the [Euclidian Algorithm][Euclidean Algorithm] to accomplish this. 
- **Examples:**
```
gcd 8 12 = 4
gcd 54 24 = 6
gcd 10 0 = 10
gcd 0 10 = 10
gcd 0 0 = 0 
```

#### ack m n
- **Type**: `int -> int -> int`
- **Description**: Returns the value of the [Ackermann–Péter function][Ackermann–Péter function] for `m` and `n`. 
- **Examples:**
```
ack 0 0 = 1
ack 0 5 = 6
ack 3 0 = 5
ack 3 3 = 61
```

Part 2: Simple List Functions
------------------------
Implement the following simple functions on lists. No recursion is needed. 

#### second_element lst
- **Type**: `int list -> int`
- **Description**: Returns the second element of `lst`, or -1 if `lst` has less than 2 elements.
- **Examples:**
```
second_element [] = -1
second_element [1] = -1
second_element [4; 2] = 2
second_element [4; 6; 9] = 6
```

#### max_first_three lst
- **Type**: `int list -> int`
- **Description**: Returns the maximum of the first three elements of `lst`, the maximum of all elements if `lst` has less than 3 elements, and -1 if the list is empty.
- **Examples:**
```
max_first_three [] = -1
max_first_three [5] = 5
max_first_three [5; 6] = 6
max_first_three [4; 3; 0] = 4
max_first_three [1; 1; 1; 7] = 1
```

Part 3: Recursive List Functions
--------------------------------
The following list functions will require recursion to complete. Include the `rec` keyword in your function definition to make use of recursion or you will get an unbound value error.

#### partial_sum i lst
- **Type**: `int -> int list -> int`
- **Description**: Returns the sum of the values from index 0 to index `i` (0-indexed) of `lst` inclusive. If `i` is greater than greatest index of `list`, return the sum of all elements of `list`. You may assume `i` is non-negative, and your implementation does not have to worry about this case.
- **Examples:**
```
partial_sum 0 [5;6;7;3] = 5
partial_sum 1 [5;6;7;3] = 11
partial_sum 4 [5;6;7;3] = 21
partial_sum 2 [] = 0
```

#### partial_sums is lst
- **Type**: `int list -> int list -> int list`
- **Description**: Returns a list where the values correspond to the partial sums from 0 to each index of `lst` listed in `is`. Follows the same rules as partial_sum for special cases.
- **Examples:**
```
partial_sums [0;1] [5;6;7;3] = [5;11] 
partial_sums [1;4] [5;6;7;3] = [11;21]
partial_sums [] [5;6;7;3] = []
partial_sums [0;1] [] = [0;0]
```

#### zip lst
- **Type**: `'a list -> 'b list -> ('a * 'b) list`
- **Description**: Given two lists, returns list of pairs where elements at the same index are paired up in the same order. If one of the lists runs out of elements don't construct any more pairs.
- **Examples:**
```
zip [1;3] [2;4] = [(1,2);(3,4)] 
zip [1;3] [2;4;5] = [(1,2);(3,4)] 
zip [] [5;4;3] = []
zip [] [] = []
```

#### index x lst
- **Type**: `'a -> 'a list -> int`
- **Description**: Returns the leftmost index (0-indexed) of element `x` in `lst`, or -1 if no occurrence is found. (Hint: You may find it useful to write a helper function.)
- **Examples:**
```
index 1 [1;2] = 0 
index "bat" ["apple";"bat";"bat";"door"] = 1
index 5 [1;2;3] = -1
```

Part 4: Set Implementation using Lists
--------------------------------------

For this part of the project, you will implement sets. In practice, sets are implemented using data structures like balanced binary trees or hash tables. However, your implementation must represent sets using lists. While lists don't lend themselves to the most efficient possible implementation, they are much easier to work with.

For this project, we assume that sets are unordered, homogeneous collections of objects without duplicates. The homogeneity condition ensures that sets can be represented by OCaml lists, which are homogeneous. The only further assumptions we make about your implementation are that the empty list represents the empty set, and that it obeys the standard laws of set theory. For example, if we insert an element `x` into a set `a`, then ask whether `x` is an element of `a`, your implementation should answer affirmatively.

Finally, note the difference between a collection and its implementation. Although *sets* are unordered and contain no duplicates, your implementation using lists will obviously store elements in a certain order and may even contain duplicates. However, there should be no observable difference between an implementation that maintains uniqueness of elements and one that does not; or an implementation that maintains elements in sorted order and one that does not.

Depending on your implementation, you may want to re-order the functions you write. Feel free to do so.

If you do not feel so comfortable with sets see the [Set Wikipedia Page][SetWiki] and/or this [Set Operations Calculator][SetOpCalc].

#### insert x a
- **Type**: `'a -> 'a list -> 'a list`
- **Description**: Inserts `x` into the set `a`.
- **Examples:**
```
insert 2 []
insert 3 (insert 2 [])
insert 3 (insert 3 (insert 2 []))
```

#### elem x a
- **Type**: `'a -> 'a list -> bool`
- **Description**: Returns true iff `x` is an element of the set `a`.
- **Examples:**
```
elem 2 [] = false
elem 3 (insert 5 (insert 3 (insert 2 []))) = true
elem 4 (insert 3 (insert 2 (insert 5 []))) = false
```

#### subset a b
- **Type**: `'a list -> 'a list -> bool`
- **Description**: Return true iff `a` **is a** subset of `b`. Formally, A ⊆ B ⇔ ∀x(xϵA ⇒ xϵB). 
- **Examples:**
```
subset (insert 2 (insert 4 [])) [] = false
subset (insert 5 (insert 3 [])) (insert 3 (insert 5 (insert 2 []))) = true
subset (insert 5 (insert 3 (insert 2 []))) (insert 5 (insert 3 [])) = false
```

#### eq a b
- **Type**: `'a list -> 'a list -> bool`
- **Description**: Returns true iff `a` and `b` are equal as sets. Formally, A = B ⇔ ∀x(xϵA ⇔ xϵB). (Hint: The subset relation is anti-symmetric, meaning A ⊆ B ∧ B ⊆ A ⇒ A = B.)
- **Examples:**
```
eq [] (insert 2 []) = false
eq (insert 2 (insert 3 [])) (insert 3 []) = false
eq (insert 3 (insert 2 [])) (insert 2 (insert 3 [])) = true
```

#### remove x a
- **Type**: `'a -> 'a list -> 'a list`
- **Description**: Removes `x` from the set `a`.
- **Examples:**
```
elem 3 (remove 3 (insert 2 (insert 3 []))) = false
eq (remove 3 (insert 5 (insert 3 []))) (insert 5 []) = true
```

#### union a b
- **Type**: `'a list -> 'a list -> 'a list`
- **Description**: Returns the union of the sets `a` and `b`. Formally, A ∪ B = {x | xϵA ∨ xϵB}.
- **Examples:**
```
eq (union [] (insert 2 (insert 3 []))) (insert 3 (insert 2 [])) = true
eq (union (insert 5 (insert 2 [])) (insert 2 (insert 3 []))) (insert 3 (insert 2 (insert 5 []))) = true
eq (union (insert 2 (insert 7 [])) (insert 5 [])) (insert 5 (insert 7 (insert 2 []))) = true
```

#### intersection a b
- **Type**: `'a list -> 'a list -> 'a list`
- **Description**: Returns the intersection of sets `a` and `b`. Formally, A ∩ B = {x | xϵA ∧ xϵB}.
- **Examples:**
```
eq (intersection (insert 3 (insert 5 (insert 2 []))) []) [] = true
eq (intersection (insert 5 (insert 7 (insert 3 (insert 2 [])))) (insert 6 (insert 4 []))) [] = true
eq (intersection (insert 5 (insert 2 [])) (insert 4 (insert 3 (insert 5 [])))) (insert 5 []) = true
```

#### product a b
- **Type**: `'a list -> 'b list -> ('a * 'b) list`
- **Description**: Returns the Cartesian product of sets `a` and `b`. Formally, A × B = {(x,y) | xϵA ∧ yϵB}. (Hint: You may find it useful to write a helper function.)
- **Examples:**
```
eq (product [] []) [] = true
eq (product (insert 2 []) []) [] = true
eq (product (insert 2 []) (insert 2 [])) (insert (2,2) []) = true
eq (insert (2,3) (insert (2,9) [])) (product (insert 2 []) (insert 3 (insert 9 []))) = true 
``` 
 
Project Submission
------------------
You should submit a file `basics.ml` containing your solution. You may submit other files, but they will be ignored during grading. We will run your solution as individual OUnit tests just as in the provided public test file.

Be sure to follow the project description exactly! Your solution will be graded automatically, so any deviation from the specification will result in lost points.

You can submit your project in two ways:
- Submit your `basics.ml` file directly to the [submit server][submit server] by clicking on the submit link in the column "web submission".
![Where to find the web submission link][web submit link]  
Then, use the submit dialog to submit your `basics.ml` file directly.
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
[submit server]: https://submit.cs.umd.edu
[web submit link]: ../common-images/web_submit.jpg
[web upload example]: ../common-images/web_upload.jpg
[Euclidean Algorithm]: https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/the-euclidean-algorithm
[Ackermann–Péter function]:https://en.wikipedia.org/wiki/Ackermann_function
[SetOpCalc]: https://www.mathportal.org/calculators/misc-calculators/sets-calculator.php
[SetWiki]:https://en.wikipedia.org/wiki/Set_(mathematics)#External_links
