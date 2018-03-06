# Project 3b: SmallC Interpreter
CMSC 330, Spring 2018
Due March 13th at 11:59pm (Late: March 14th at 11:59pm)

P/R/S: 50/50/0

Ground Rules and Extra Info
---------------------------
This is **NOT** a pair project. You must work on this project alone as with most other CS projects. See the Academic Integrity section for more information.

For this project, post questions using the `Project 3` folder on Piazza. 

In your code, you may use **any** non-imperative standard library functions (with the exception of printing), but the ones that will be useful to you will be found in the [`Pervasives` module][pervasives doc] and the [`List` module][list doc]. Note that the `List` module has been disallowed in previous projects, but in the case of this project and projects going forward it will be allowed.

You still may not use any imperative structures of OCaml such as references or the `Hashtbl` module.

Introduction
------------
Up to this point your exposure to OCaml has been in an effort to familiarize you with the language, and you should now have a basic understanding of OCaml's deeply integrated typing and pattern systems. It's because of these elegant constructs that OCaml has gained popularity as programming language implementation language. Many compilers classes (including CMSC430 at UMD) use OCaml. Facebook uses OCaml heavily, too, e.g., for [Hack][hack github], its PHP-based web language.

In this project, you will implement a small subset of an interpreter for SmallC, a small C-like language. The language supports variables, `int` and `bool` types, equality and comparison operations, math and boolean operations, control flow, and printing, all while maintaining static type-safety and being Turing complete!

The language consists of expressions from the `expr` type and statements from the `stmt` type. These algebraic types can be used to represent the full space of properly formed SmallC programs. Their definitions are found in the `types.ml` file. This file should be a constant reference to the data types involved in successfully working with SmallC.

This project is the second part of a project you will do later in the semester, in which you will write the parser for SmallC. In order to run SmallC code it first goes through a lexer, then a parser, and then this interpreter. The lexer and parser are both provided for this project, but later you will write a parser of your own! 

Project Files
-------------
To begin this project, you will need to commit any uncommitted changes to your local branch and pull updates from the git repository. [Click here for directions on working with the Git repository.][git instructions] The following are the relevant files:

-  OCaml Files
  - **eval.ml**: All of your code will all be written in the file `eval.ml`. _None of the files other than this one should be changed._
  - **eval.mli**: This is the _interface_ for `eval.ml`. It defines what types and functions are visible to modules outside of `eval.ml` (such as `smallc.ml`, listed below).
  - **studentTests.ml**: You aren't required to use this file, but you may use it to add your own tests to the project. We've included some small notes on writing OUnit tests and our test utilities for this project, which we discuss below if you're interested in this method of testing.
  - **lexer.cm[oi]** and **parser.cm[oi]**: These precompiled object and interface files contain the lexer and parser used for turning plain files into OCaml datatypes. They are precompiled because you will implement your own parser in project 5.
  - **public.ml** and **public_inputs/**: The public test driver file and the SmallC input files to go with it, respectively.
  - **smallc.ml**: A frontend to your interpreter used to build the `smallc` executable target. This is explained in more detail below.
  - **types.ml**: This file contains all type definitions used in this project.
  - **utils.ml** and **testUtils.ml**: These files contain functions that we have written for you and for us that aid in testing and debugging. The small part of **utils.ml** that concerns you in implementing this project is called out very explicitly when it is needed later in the document, and otherwise you should not need to look at either of these files.
- Submission Scripts and Other Files
  - **submit.rb**: Execute this script to submit your project to the submit server.
  - **submit.jar** and **.submit**: Don't worry about these files, but make sure you have them.
  - **Makefile**: This is used to build the public tests by simply running the command `make`, just as in 216.

Compilation, Tests, and Running
-------------------------------
In order to compile your project, simply run the `make` command and our `Makefile` will handle the compilation process for you, just as in 216. After compiling your code, three executable files will be created:
- public
- smallc
- student

The public tests can be run by simply running `public` (i.e. `./public` in the terminal; think of this just like with a.out in C).

You can run the SmallC interpreter directly on a SmallC program by running `./smallc <filename>`. This driver, provided by us, reads in a program from a file and evaluates the code, outputing the results of any print statements present in the source file. Think of this command a lot like the `ruby` command, but instead of running the ruby interpreter, it runs the SmallC interpreter that you wrote yourself!

If you would like more detailed information about what your code produced, running `./smallc <filename> -R` provides a report on the resultant variable bindings as reported by your evaluator. If you would like to see data structure that is being generated by the parser and being fed into your interpreter, run `./smallc <filename> -U` and our `Utils` module will translate the data structure into a string and print it out for you - this part does not require any of your code, so feel free to try it on the public tests before you even start! Use the `smallc` executable to your advantage when testing; that's why we're providing it! Note that you don't need to touch `smallc.ml` yourself, as it only functions as an entry point for the interpreter and is independent of your implementation.

The `studentTests.ml` file compiles into the `student` binary, which behaves just like the `public` binary except serves as a dedicated space for you to write your own test cases. We offer a few small notes on how to do this, however full information on OUnit can be found online and our testing tools can be seen in full use in the `public.ml` test cases, and then emulated. You are **NOT** required to use this file at all, and if you don't touch it, it won't affect your code at all. If you want more information about writing student tests within our framework, post on Piazza.

In order to compile against the provided parser and lexer, you must be on OCaml version 4.04.0.

The Evaluator
-------------
*The evaluator must be implemented in `eval.ml` in accordance with the signatures for `eval_expr` and `eval_stmt` found in `eval.mli`. `eval.ml` is the only file you will write code in. The functions should be left in the order they are provided, as your implementation of `eval_stmt` will rely on `eval_expr`.*

The heart of SmallC is your evaluator. We have already implemented `Lexer` and `Parser` modules that deal with constructing tokens and creating the AST out of a program. Where your code picks up is with a representation of SmallC programs as OCaml datatypes, which you are then responsible for evaluating according the rules below. A program is made up of a series of statements and expressions:

- Statements represent the structure of a program - declarations, assignments, control flow, and prints in the case of SmallC. - Expressions represent operations on data - variable lookups, mathematical and boolean operations, and comparison. Expressions can't affect the environment, and as a result only return a `value` containing the value of the expression.

You are responsible for implementing two functions, `eval_expr` and `eval_stmt` in that order. Each of these takes as an argument an `environment` (given in `types.ml`) that is an association list. An association list is a list of pairs (2-tuples) where the key is the first element of the pair and the value is the second element. Elements earlier in the list override elements later in the list. In our case the association list is of type `(string * value) list` where the string is the id name and the value is the current value of that id. **The List module has many useful functions for working with association lists**. Statements may change the values of variables, so `eval_stmt` returns a possibly updated environment.

A formal operational semantics of SmallC can be found in [`semantics.pdf`][semantics document]. We highly recommend you read this document as you work to clear up any possible ambiguity introduced by the English explanations below. The formal semantics do not, however, define error cases such as addition between a boolean and an integer and therefore represent a stuck reduction. The expected behavior for these irreducable error cases are defined only in this document and can be boiled down to the following rules:
- Any expression containing division by zero should raise a DivByZero error when evaluated.
- Any expression or statement that is applied to the wrong types should raise a `TypeError` exception when evaluated, for example, the expression `1 + true` would result in `TypeError`.
- An expression or statement that redefines an already defined variable, assigns to an undefined variable, or reads from an undefined variable should raise a `DeclareError` when evaluated.

We do not enforce what messages you use when raising the `TypeError` or `DeclareError` exceptions; that's up to you. Evaluation of subexpressions should be done from left to right, as specified by the semantics, in order to ensure that lines with multiple possible errors match up with our expected errors.

### Part 1: eval_expr

`eval_expr` takes an environment `env` and an expression `e` and produces the result of _evaluating_ `e`, which is something of type `value` (`Int_Val` or `Bool_Val`).

#### Int

Integer literals evaluate to a `Int_Val` of the same value.

#### Bool

Boolean literals evaluate to a `Bool_Val` of the same value.

#### ID

An identifier evaluates to whatever value it is mapped to by the environment. Should raise a `DeclareError` if the identifier has no binding.

#### Add, Sub, Mult, Div, and Pow

*These rules are jointly classified as BinOp-Int in the formal semantics.*

These mathematical operations operate only on integers and produce a `Int_Val` containing the result of the operation. All operators must work for all possible integer values, positive or negative, except for division, which will raise a `DivByZeroError` exception on an attempt to divide by zero. If either argument to one of these operators evaluates to a non-integer, a `TypeError` should be raised.

#### Or and And

*These rules are jointly classified as BinOp-Bool in the formal semantics.*

These logical operations operate only on booleans and produce a `Bool_Val` containing the result of the operation. If either argument to one of these operators evaluates to a non-boolean, a `TypeError` should be raised.

#### Not

The unary not operator operates only on booleans and produces a `Bool_Val` containing the negated value of the contained expression. If the expression in the `Not` is not a boolean (and does not evaluate to a boolean), a `TypeError` should be raised.

#### Greater, Less, GreaterEqual, LessEqual

*These rules are jointly classified as BinOp-Int in the formal semantics*

These relational operators operate only on integers and produce a `Bool_Val` containing the result of the operation. If either argument to one of these operators evaluates to a non-integer, a `TypeError` should be raised.

#### Equal and NotEqual

These equality operators operate both on integers and booleans, but both subexpressions must be of the same type. The operators produce a `Bool_Val` containing the result of the operation. If the two arguments to these operators do not evaluate to the same type (i.e. one boolean and one integer), a `TypeError` should be raised.

### Part 2: eval_stmt

`eval_stmt` takes an environment `env` and a statement `s` and produces an updated `environment` (defined in Types) as a result. This environment is represented as `a` in the formal semantics, but will be referred to as the environment in this document.

#### NoOp

`NoOp` is short for "no operation" and should do just that - nothing at all. It is used to terminate a chain of sequence statements, and is much like the empty list in OCaml in that way. The environment should be returned unchanged when evaluating a `NoOp`.

#### Seq

The sequencing statement is used to compose whole programs as a series of statements. When evaluating `Seq`,  evaluate the first substatement under the environment `env` to create an updated environment `env'`. Then, evaluate the second substatement under `env'`, returning the resulting environment.

#### Declare

The declaration statement is used to create new variables in the environment. If a variable of the same name has already been declared, a `DeclareError` should be raised. Otherwise, if the type being declared is `Int_Type`, a new binding to the value `Int_Val(0)` should be made in the environment. If the type being declared is `Bool_Type`, a new binding to the value `Bool_Val(false)` should be made in the environment. The updated environment should be returned.

#### Assign

The assignment statement assigns new values to already-declared variables. If the variable hasn't been declared before assignment, a `DeclareError` should be raised. If the variable has been declared to a different type than the one being assigned into it, a `TypeError` should be raised. Otherwise, the environment should be updated to reflect the new value of the given variable, and an updated environment should be returned.

#### If

The `if` statement consists of three components - a guard expression, an if-body statement and an else-body statement. The guard expression must evaluate to a boolean - if it does not, a `TypeError` should be raised. If it evaluates to true, the if-body should be evaluated. Otherwise, the else-body should be evaluated instead. The environment resulting from evaluating the correct body should be returned.

#### While

The while statement consists of two components - a guard expression and a body statement. The guard expression must evaluate to a boolean - if it does not, a `TypeError` should be raised. If it evaluates to `true`, the body should be evaluated to produce a new environment and the entire loop should then be evaluated again under this new environment, returning the environment produced by the reevaluation. If the guard evaluates to `false`, the current environment should simply be returned.

*The formal semantics rule for while loops is particularly helpful!*

#### Print

The print statement is your project's access to standard output. First, the expression to `print` should be evaluated. Print supports both integers and booleans. Integers should print in their natural forms (i.e. printing `Int_Val(10)` should print "10". Booleans should print in plaintext (i.e. printing `Bool_Val(true)` should print "true" and likewise for "false"). Whatever is printed should always be followed by a newline.

**VERY IMPORTANT NOTE ON PRINTING**: If you attempt to print with `print_string`, `print_int`, etc... you will fail any test that checks your output. This is because we do not directly intercept your output, but rather have implemented some wrapper functions in the `Utils` for program printing (do not remove `open Utils` from the top of `eval.ml`!). As a result, your code may have any amount of `print_string` statements and it **WILL NOT** affect the tests. Only printing performed through the following wrapper functions will be evaluated by the test system, and as a result should be used exclusively with `Print`. The supplied print wrappers which you *must use in place of the built-in print functions for any and all output resulting from `Print` statements and for nothing else* are as follows:
- `print_output_string : string -> unit`
- `print_output_int : int -> unit`
- `print_output_bool : bool -> unit`
- `print_output_newline : unit -> unit`
Again, you may use the normal prints defined in the standard library `Pervasives` module, but they will not affect your test grading in any way.

Project Submission
------------------
You should submit the file `eval.ml` containing your solution. You may submit other files, but they will be ignored during grading. We will run your solution as individual OUnit tests just as in the provided public test file.

Be sure to follow the project description exactly! Your solution will be graded automatically, so any deviation from the specification will result in lost points.

You can submit your project in two ways:
- Submit your files directly to the [submit server][submit server] as a zip file by clicking on the submit link in the column "web submission".
![Where to find the web submission link][web submit link]  
Then, use the submit dialog to submit your zip file containing `eval.ml` directly.
![Where to upload the file][web upload example]  
Select your file using the "Browse" button, then press the "Submit project!" button. You will need to put it in a zip file since there are two component files.
- Submit directly by executing a the submission script on a computer with Java and network access. Included in this project are the submission scripts and related files listed under **Project Files**. These files should be in the directory containing your project. From there you can either execute submit.rb or run the command `java -jar submit.jar` directly (this is all submit.rb does).

No matter how you choose to submit your project, make sure that your submission is received by checking the [submit server][submit server] after submitting.

Academic Integrity
------------------
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will be** submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

<!-- Link References -->
[list doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html
[hack github]: https://github.com/facebook/hhvm/tree/master/hphp/hack
[semantics document]: semantics.pdf

<!-- These should always be left alone or at most updated -->
[pervasives doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
[git instructions]: ../git_cheatsheet.md
[submit server]: submit.cs.umd.edu
[web submit link]: image-resources/web_submit.jpg
[web upload example]: image-resources/web_upload.jpg

