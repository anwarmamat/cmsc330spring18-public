# Project 4: Regular Expression Interpreter

CMSC 330, Spring 2018

Due Mon, April 2nd

P/R/S: 35/35/30

Ground Rules
---------------------------
**This is an individual assignment. You must work on this project alone.**

For this project you are allowed to use the library functions found in the [`Pervasives` module][pervasives doc], as well as functions from the [`List`][list doc] and [`String`][string doc] modules. As in the previous project, you are not allowed to use imperative OCaml. You will receive a 0 for any functions using restricted features—we will be checking your code!

Introduction
------------
Your job is to implement the `Nfa` and `Regexp` modules, which implement NFAs and a regular expressions interpreter, respectively. The signature and starter implementation for the two modules is provided. Please take a look at the interface files (`nfa.mli` and `regexp.mli`) before beginning the project. You may not change the module signatures in any way, though your implementation may include more types and functions than are listed in the signatures. The `Regexp` module implementation contains a parser you can use to test your implementation.

Project Files
-------------
To begin this project, you will need to commit any uncommitted changes to your local branch and pull updates from the git repository. [Click here for directions on working with the Git repository.][git instructions] The following are the relevant files:

* OCaml Files
  * __nfa.ml__ and __nfa.mli__: This is where you will write your code for the first part of the project, the NFA implementation.
    * Note that you will not change `nfa.mli`!
  * __regexp.ml__ and __regexp.mli__: This is where you will write your code for the second part of the project, the regular expressions interpreter. It also contains an implementation of a parser where you can use some of the funtions such as `string_to_regexp` and `string_to_nfa` for creating your own test cases.
    * Note that you will not change `regexp.mli`!
  * __public.ml__: This file contains all of the public test cases.
  * __sets.cm[oi]__: These precompiled object and interface files contain the sets implementation from P2A.
  * __viz.ml__: This script can be used to display regex NFAs. This is a very useful debugging tool! Described more below.
* Submission Scripts and Other Files
  * __submit.rb__: Execute this script to submit your project to the submit server.
  * __submit.jar and .submit__: These files are used by the ruby file above, do not worry about them.
  * __Makefile__: This is used to build all project executables.

Compilation and Tests
---------------------
In order to compile your project, simply run the `make` command and our Makefile will handle the compilation process for you. After compiling your code, running the `public.native` binary will execute the public tests. (I.e., do `./public.native`; think of this just like with `a.out` in C, just named `public.native` instead of `a.out`.)

For testing your regular expressions, we've provided another build target: `viz.native`. When you run this command, it will read a regular expression from standard in, compose an NFA from it, and export that NFA to Graphviz before rendering to a PNG. For this target to work, however, you must install Graphviz:
- MacOS: `brew install graphviz`
- Aptitude-based Linux: `sudo apt-get install libgraphviz-dev`
  - This includes the class VM, Ubuntu, Debian, and any Debian derivative OS

Note that you are **not** required to do this, it will just be immensely helpful in debugging your code. Once you've performed these steps, you can run the visualizer as follows:

1. Run the command `./viz.native` to open the input shell.
2. The shell will ask for a regular expression. Type without spaces and using only the constructs supported by this project.
3. Select if you want to convert the NFA to a DFA (with your conversion function) before visualizing.
4. You should be notified that the image has been successfully generated and put in `output.png`.
5. Use an image viewer of choice to open `output.png` and see the visual representation of your generated NFA.

If you would like to do testing of your code in the toplevel, we have set up an init file so that when you simply run `ocaml` to open the toplevel like normal, your `Nfa` and `Regexp` modules are loaded as well. This will only work, however, after a build (i.e. the `_build` directory is intact with the cmo and cmi files). If you get a message of the form `Cannot find file...` when starting the toplevel, it's because you need to run `make` before opening the toplevel.

One final general note: This project makes use of OCaml's module system. However, you don't need any level of detailed knowledge about modules to successfully implement this project. Your work will take place in both the `Nfa` and `Regexp` modules, and the `Regexp` module will refer to many functions in the `Nfa` module. At a base level, this is purely organizational choice. If you would like to learn more about modules, check out the [Real World OCaml Modules Chapter][modules doc] for a straightforward explanation of modules in OCaml. If you want to be more proficient in OCaml, a basic understanding of the module system will make many seemingly cryptic programs much more readable.

The NFA Type
------------
Before starting, you'll want to familiarize yourself with the types you will be working with.

The type `nfa_t` is the type representing NFAs. It is modeled after the formal definition of an NFA, a 5-tuple (Q, Σ, δ, q0, F) where:

1. Q is a finite set of states,
2. Σ is a finite alphabet,
3. δ : Q × (Σ ∪ {ε}) → P(Q) is the transition function,
4. q0 ∈ Q is the start state, and
5. F ⊆ Q is the set of accept states.

We translate this definition into OCaml in a straightforward way using record syntax:

```
type ('q, 's) transition = 'q * 's option * 'q
type ('q, 's) nfa = {
    qs : 'q list;
    sigma : 's list;
    delta : ('q, 's) transition list;
    q0 : 'q;
    fs : 'q list;
}
```

Notice the types are parametric in state `'q` and symbol `'s`.

The type `transition` represents NFA transitions. For example:
```
let t1 = (0, Some c, 1) (* Transition from state 0 to state 1 on character 'c' *)
let t2 = (1, None, 0)   (* Transition from state 1 to state 0 on epsilon *)
```

An example NFA would be:

```
let m = {
    qs = [0;1;2];
    sigma = ['a'];
    delta = [(0, Some 'a', 1); (1, None, 2)];
    q0 = 0;
    fs = [2]
}
```

This looks like:

![NFA m](m_viz.png)

Here is a DFA:

```
let n = {
    qs = [0;1;2];
    sigma = ['a';'b';'c'];
    delta = [(0, Some 'a', 1); (1, Some 'b', 0); (1, Some 'c', 2)];
    q0 = 0;
    fs = [2]
}
```

This looks like:

![NFA n](n_viz.png)

Utility Functions
-----------------
We have included correct implementations of the [set functions from P2A](../p2a#part-4-set-implementation-using-lists). You
may use these in your solution. We have also provided a number of other potentially
useful functions.

**explode s**

* **Type:** `string -> char list`
* **Description:** Takes a string as input and returns representation of the string as a list of characters.

**fix comp f x0**

* **Type:** `('a -> 'a -> bool) -> ('a -> 'a) -> 'a -> 'a`
* **Description:** Takes an equality predicate `comp`, function `f`, and initial value `x0` and computes the fixpoint of `f` by iteration starting from `x0` and using `comp` to determine equality. (This might be helpful if you decide to implement `e_closure` and `nfa_to_dfa` by fixpoint iteration. The [following document](fixpoint.pdf) may be a useful reference.)

Part 1: NFAs
------------
You must implement the following functions as specified.

**move m l c**

* **Type:** `('q, 's) nfa_t -> 'q list -> 's option -> 'q list`
* **Description:** This function takes as input an NFA, a list of initial states, and a symbol option. The output will be a list of states (in any order, with no duplicates) that the NFA might be in after making one transition on the symbol (or epsilon if None), starting from one of the initial states given as an argument to move.
* **Examples:**
```
move m [0] (Some 'a') = [1] (* m is the NFA defined above *)
move m [1] (Some 'a') = []
move m [2] (Some 'a') = []
move m [0;1] (Some 'a')  = [1]
move m [1] None = [2]
```
* **Explanation:**
  1. Move on `m` from `0` with `Some a` returns `[1]` since from 0 to 1 there is a transition with character `a`.
  2. Move on `m` from `1` with `Some a` returns `[]` since from 1 there is no transition with character `a`.
  3. Move on `m` from `2` with `Some a` returns `[]` since from 2 there is no transition with character `a`.
  4. Move on `m` from `0` and `1` with `Some a` returns `[1]` since from 0 to 1 there is a transition with character `a` but from 1 there was no transition with character `a`.
  5. Notice that the NFA uses an implicit dead state. If `s` is a state in the input list and there are no transitions from `s` on the input character, then all that happens is that no states are added to the output list for `s`.
  6. Move on `m` from `1` with `None` returns `[2]` since from 1 to 2 there is an epsilon transition.

**e_closure m l**

* **Type:** `('q, 's) nfa_t -> 'q list -> 'q list`
* **Description:** This function takes as input an NFA and a list of states. The output will be a list of states (in any order, with no duplicates) that the NFA might be in making zero or more epsilon transitions, starting from the list of initial states given as an argument to `e_closure`.
* **Examples:**
```
e_closure m [0] = [0] (* where m is the NFA created above *)
e_closure m [1] = [1;2]
e_closure m [2]  = [2]
e_closure m [0;1] = [0;1;2]
```
* **Explanation:**
  1. e_closure on `m` from `0` returns `[0]` since there is no where to go from `0` on an epsilon transition.
  2. e_closure on `m` from `1` returns `[1;2]` since from `1` you can get to `2` on an epsilon transition.
  3. e_closure on `m` from `2` returns `[2]` since there is no where to go from `2` on an epsilon transition.

**accept m s**

* **Type:** `('q, char) nfa_t -> string -> bool`
* **Description:** This function takes an NFA and a string, and returns true if the NFA accepts the string, and false otherwise. You will find the functions in the [`String` module][string doc] to be helpful. (Hint: You should implement this function without using `nfa_to_dfa`.)
* **Examples:**
```
accept n "" = false  (* n is the NFA defined above *)
accept n "ac" = true
accept n "abc" = false
accept n "abac" = true
```
* **Explanation:**
  1. accept on `n` with the string "" returns false because initially we are at our start state 0 and there are no characters to exhaust and we are not in a final state.
  2. accept on `n` with the string "ac" returns true because from 0 to 1 there is an 'a' transition and from 1 to 2 there is a 'c' transition and now that the string is empty and we are in a final state thus the nfa accepts "ac".
  3. accept on `n` with the string "abc" returns false because from 0 to 1 there is an 'a' transition but then to use the 'b' we go back from 1 to 0 and we are stuck because we need a 'c' transition yet there is only an 'a' transition. Since we are not in a final state thus the function returns false.
  4. accept on `n` with the string "abac" returns true because from 0 to 1 there is an 'a' transition but then to use the 'b' we go back from 1 to 0 and then we take an 'a' transition to go to state 1 again and then finally from 1 to 2 we exhaust our last character 'c' to make it to our final state. Since we are in a final state thus the nfa accepts "abac". 4. eclosure on `m` from `0` and `1` returns `[0;1;2]` since from `0` you can only get to yourself and from `1` you can get to `2` on an epsilon transition but from `2` you can't go anywhere.

**nfa_to_dfa m**
* **Type:** `('q, 's) nfa_t -> ('q list, 's) nfa_t`
* **Description:** This function takes as input an NFA and converts it to an equivalent DFA. Notice the return type is an `nfa_t`. This is not a typo, every DFA is an NFA (not the other way around though), a restricted kind of NFA. Namely, it may not have non-deterministic transitions (i.e. epsilon transitions or more than one transition out of a state with the same symbol). The language recognized by an NFA is invariant under `nfa_to_dfa`. In other words, for all NFAs `m` and for all strings `s`, `accept m s = accept (nfa_to_dfa m) s`.

Part 2: Regular Expressions
---------------------------
The `Regexp` module contains the following type declaration:
```
type regexp_t =
  | Empty_String
  | Char of char
  | Union of regexp * regexp
  | Concat of regexp * regexp
  | Star of regexp
```
Here regexp_t is a user-defined OCaml variant datatype representing regular expressions
* `Empty_String` represents the regular expression recognizing the empty string (not the empty set!). Written as a formal regular expression, this would be `epsilon`.
* `Char c` represents the regular expression that accepts the single character c. Written as a formal regular expression, this would be `c`.
* `Union (r1, r2)` represents the regular expression that is the union of r1 and r2. For example, `Union(Char 'a', Char'b')` is the same as the formal regular expression `a|b`.
* `Concat (r1, r2)` represents the concatenation of r1 followed by r2. For example, `Concat(Char 'a', Char 'b')` is the same as the formal regular expresion `ab`.
* `Star r` represents the Kleene closure of regular expression r. For example, `Star (Union (Char 'a', Char 'b'))` is the same as the formal regular expression `(a|b)*`.

You must implement your own function to convert a regular expression (in the above format) to an NFA, which you can then use to match particular strings (by leveraging your `Nfa` module). You must also implement a function that turns `regexp_t` structures back into a string representation.

**regexp_to_nfa re**

* Type: `regexp_t -> nfa_t`
* Description: This function takes a regexp and returns an NFA that accepts the same language as the regular expression. Notice that as long as your NFA accepts the correct language, the structure of the NFA does not matter since the NFA produced will only be tested to see which strings it accepts.

**regexp_to_string re**

* **Type**: `regexp_t -> string`
* Description: This function takes a regular expression and returns a string representation of the regular expression in standard infix notation. How to deal with associativity and precedence is up to you - your output will be tested by running it back through the parser to check that your generated string is equivalent to the original regular expression, so excess parentheses will not be penalized.
* Examples:
```
regexp_to_string (Char 'a') = "a"
regexp_to_string (Union (Char 'a', Char 'b')) = "a|b"
regexp_to_string (Concat(Char 'a',Char 'b')) = "ab"
regexp_to_string (Concat(Char 'a',Concat(Char 'a',Char 'b'))) = "aab"
regexp_to_string (Star(Union(Char 'a',Empty_String))) = "(a|E)*" (* Note that 'E' represents epsilon! *)
regexp_to_string (Concat(Star(Union(Char 'a',Empty_String)),Union(Char 'a',Char 'b'))) = "(a|E)*(a|b)"
```
* **Hint:** You can do this as an in-order DFS traversal over the regexp data structure.

The rest of these functions are implemented for you as helpers. However, they rely on your code for correctness!

**string_to_nfa s**
* **Type:** `string -> nfa`
* **Description:** This function takes a string for a regular expression, parses the string, converts it into a regexp, and transforms it to an nfa, using your `regexp_to_nfa` function. As such, for this function to work, your `regexp_to_nfa` function must be working. In the starter files we have provided function `string_to_regexp` that parses strings into `regexp` values, described next.

**string_to_regexp s** (provided for you)
* **Type:** `string -> regexp`
* **Description:** This function takes a string for a regular expression, parses the string, and outputs its equivalent regexp. If the parser determines that the regular expression has illegal syntax, it will raise an IllegalExpression exception.
* **Examples:**
```
string_to_regexp "a" = Char 'a'
string_to_regexp "(a|b)" = Union (Char 'a', Char 'b')
string_to_regexp "ab" = Concat(Char 'a',Char 'b')
string_to_regexp "aab" = Concat(Char 'a',Concat(Char 'a',Char 'b'))
string_to_regexp "(a|E)*" = Star(Union(Char 'a',Empty_String))
string_to_regexp "(a|E)*(a|b)" = Concat(Star(Union(Char 'a',Empty_String)),Union(Char 'a',Char 'b'))

```
In a call to `string_to_regexp s` the string `s` may contain only parentheses, |, \*, a-z (lowercase), and E (for epsilon). A grammatically ill-formed string will result in `IllegalExpression` being thrown. Note that the precedence for regular expression operators is as follows, from highest(1) to lowest(4):

Precedence | Operator | Description
---------- | -------- | -----------
1 | () | parentheses
2 | * | closure
3 |  | concatenation
4 | &#124; | union

Also, note that all the binary operators are **right associative**.

Project Submission
------------------
You should submit the files `nfa.ml` and `regexp.ml` containing your solution. You may submit other files, but they will be ignored during grading. We will run your solution as individual OUnit tests just as in the provided public test file.

** If you submit your entire directory ENSURE you do `make clean` before submitting or it will not compile **

Be sure to follow the project description exactly! Your solution will be graded automatically, so any deviation from the specification will result in lost points.

You can submit your project in two ways:

* Submit your files directly to the [submit server][submit server] by clicking on the submit link in the column next to the project number. Then, use the submit dialog to submit all your files.
Select your file using the "Browse" button, then press the "Submit project!" button. You do not need to put it in a zip file.
* Submit directly by executing a the submission script on a computer with Java and network access. Included in this project are the submission scripts and related files listed under Project Files. These files should be in the directory containing your project. From there you can either execute `ruby submit.rb` or run the command `java -jar submit.jar` directly (this is all submit.rb does).
No matter how you choose to submit your project, make sure that your submission is received by checking the [submit server][submit server] after submitting.

Academic Integrity
------------------
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will** be submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

[list doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html
[string doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/String.html
[modules doc]: https://realworldocaml.org/v1/en/html/files-modules-and-programs.html

<!-- These should always be left alone or at most updated -->
[pervasives doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
[git instructions]: ../git_cheatsheet.md
[wikipedia inorder traversal]: https://en.wikipedia.org/wiki/Tree_traversal#In-order
[submit server]: submit.cs.umd.edu
[web submit link]: image-resources/web_submit.jpg
