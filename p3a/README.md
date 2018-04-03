# Project 3A: SmallC Parser
CMSC 330, Spring 2018

Due April 14th at 11:59 PM (Late April 15th at 11:59 PM)

P/R/S: 48/ 52/ 0

Ground Rules and Extra Info
---------------------------
This **is NOT** a pair project.

In your code, you may use any OCaml modules and features we have taught in this class (If you come asking for help using something we have not taught we will direct you to use methods taught in this class). You may even choose to use imperative OCaml, but are not required to. 

Introduction
------------
In this project, you will implement the lexer and parser for SmallC, which was the input language of the interpreter you wrote in project 3b. This parser will be capable of parsing expressions, statements, and full programs, thus making it a complete replacement for the parser we supplied for the interpreter project. The parser will operate on a flat `token list` assembled by your lexer and create a correct `stmt` and/or `expr` corresponding to the input. When you're done, you will have written the complete pipeline to turn a text file into a running SmallC program!

The only requirement for error handling is that input that cannot be lexed/parsed according to the provided rules should raise an `InvalidInputException`. We recommend using relevant error messages when raising these exceptions, as it will make debugging easier.

All tests will be run on direct calls to your code, comparing your return values to the expected return values. Any other output (e.g., for your own debugging) will be ignored. You are free and encouraged to have additional output.

Project Files
-------------
To begin this project, you will need to commit any uncommitted changes to your local branch and pull updates from the git repository. [Click here for directions on working with the Git repository.][git instructions] The following are the relevant files:

- OCaml files you should edit
  - **lexer.ml**: This file is the sole place you will implement lexer code for the first half of this project.
  - **parser.ml**: This file is the sole place you will implement parser code for the second half of this project.
- Provided OCaml Files (No need to edit, changes will be overwritten!)
  - **interface.ml**: This driver can be used to output your lexer/parser results on standard input or supplied files. It's a lot like the `smallc.ml` file in project 3b, but for the frontend (parser/lexer) rather than the backend (interpreter).
  - **public.ml** and **public_inputs/**: The public test driver file and the SmallC input files to go with it, respectively.
  - **smallCTypes.ml**: This file contains all type definitions used in this project.
  - **utils.ml** and **testUtils.ml**: These files contain functions that we have written for you and for us that aid in testing and debugging. The small part of **utils.ml** that concerns you in implementing this project is called out very explicitly when it is needed later in the document, and otherwise you should not need to look at either of these files.
- Submission Scripts and Other Files
  - **submit.rb**: Execute this script to submit your project to the submit server.
  - **submit.jar** and **.submit**: Don't worry about these files, but make sure you have them.
  - **Makefile**: This is used to build the public tests and other project-specific targets by simply running the command `make`, just as in 216.

Compilation, Tests, and Running
-------------------------------
In order to compile your project, simply run the `make` command and our `Makefile` will handle the compilation process for you. After compiling your code, two executable files will be created:
- `public.byte`
- `interface.byte`

The public tests can be run by simply running `public.byte` (i.e. `./public.byte` in the terminal; think of this just like with a.out in C).

You can run your lexer or parser directly on a SmallC program by running `./interface.byte lex [filename]` or `./interface.byte parse [filename]` where the `[filename]` argument is optional. This driver, provided by us, reads in a program from standard input (or from a file, if a second argument is provided) and performs the requested action (i.e. lex or parse) and prints information about the result of running the SmallC lexer and parser that you will write.

Note that you don't need to touch `interface.ml` yourself, as it only functions as an entry point for your code and is structured independent of your exact implementation.

The Lexer
---------
Before your parser can process input, the raw file must be transformed into logical units called tokens. This process is readily handled by use of regular expressions. Information about OCaml's regular expressions library can be found in the [`Str` module documentation][str doc]. You aren't required to use it, but you may find it very helpful. Note that a lexer is the same as a scanner, which is discussed in the lecture slides. 

Your lexer must be written in `lexer.ml`. You will need to implement the function `tokenize : string -> token list` which takes as input the program as a string and outputs the associated token list. The `token` type is implemented in [`smallCTypes.ml`](./smallCTypes.ml).

Your lexer must meet these general requirements:
- Tokens can be separated by arbitrary amounts of whitespace, which your lexer should discard. Spaces, tabs ('\t') and newlines ('\n') are all considered whitespace.
- The lexer should be case sensitive.
- Lexer input should be terminated by the `EOF` token, meaning that the shortest possible output from the lexer is `[EOF]`.
- If the beginning of a string could be multiple things, the longest match should be preferred, for example:
  - "while0" should not be lexed as `Tok_While`, but as `Tok_ID("while0")`, since it is an identifier

Most tokens only exist in one form (for example, the only way for `Tok_Pow` to appear in the program is as `^` and the only way for `Tok_While` to appear in the program is as `while`). However, a few tokens have more complex rules. The regular expressions for these more complex rules are provided here:

- `Tok_Bool of bool`: The value will be set to `true` on the input string "true" and `false` on the input string "false".
  - *Regular Expression*: `true|false`
- `Tok_Int of int`: Valid ints may be positive or negative and consist of 1 or more digits. You may find the function `int_of_string` useful in lexing this token type.
  - *Regular Expression*: `-?[0-9]+`
- `Tok_ID of string`: Valid IDs must start with a letter and can be followed by any number of letters or numbers. Note that keywords may be contained within IDs and they should be counted as IDs unless they perfectly match a keyword!
  - *Regular Expression*: `[a-zA-Z][a-zA-Z0-9]*`
  - *Valid examples*:
    - "a"
    - "ABC"
    - "a1b2c3DEF6"
    - "while1"
    - "ifelsewhile"

In grammars given later in this project description, we use the lexical representation of tokens instead of the token name; e.g. we write `(` instead of `Tok_LParen`. This table shows all mappings of tokens to their lexical representations, save for the three variant tokens specified above:

Token Name (in OCaml) | Lexical Representation (in grammars below)
--- | ---
`Tok_LParen` | `(`
`Tok_RParen` | `)`
`Tok_LBrace` | `{`
`Tok_RBrace` | `}`
`Tok_Equal` | `==`
`Tok_NotEqual` | `!=`
`Tok_Assign` | `=`
`Tok_Greater` | `>`
`Tok_Less` | `<`
`Tok_GreaterEqual` | `>=`
`Tok_LessEqual` | `<=`
`Tok_Or` | `||`
`Tok_And` | `&&`
`Tok_Not` | `!`
`Tok_Semi` | `;`
`Tok_Int_Type` | `int`
`Tok_Bool_Type` | `bool`
`Tok_Print` | `printf`
`Tok_Main` | `main`
`Tok_If` | `if`
`Tok_Else` | `else`
`Tok_While` | `while`
`Tok_Add` | `+`
`Tok_Sub` | `-`
`Tok_Mult` | `*`
`Tok_Div` | `/`
`Tok_Pow` | `^`

Your lexing code will feed the tokens into your parser, so a broken lexer will render the parser useless. Test your lexer thoroughly before moving on to the parser!

The Parser
----------
Once the program has been transformed from a string of raw characters into more manageable tokens, you're ready to parse. The parser must be implemented in `parser.ml` in accordance with the signatures for `parse_expr`, `parse_stmt` and `parse_main` found in `parser.mli`. `parser.ml` is the only file you will write code in. The functions should be left in the order they are provided, as a good implementation will rely heavily on earlier functions.

We provide an **ambiguous** CFG for the language that you must convert to be right-recursive and right-associative, so it can be parsed by recursive descent. (By right associative, we are referring to binary infix operators—so something like `1 + 2 + 3` will parse as `Add(Int(1), Add(Int(2), Int(3)))`, essentially implying parentheses in the form `(1 + (2 + 3))`.) As convention, in the given CFG all non-terminals are capitalized, all syntax literals (terminals) are formatted `as non-italicized code` and will come in to the parser as tokens from your lexer. Variant token types (i.e. Tok_Bool, Tok_Int, and Tok_ID) will be printed *`as italicized code`*.

Parser Part 1: parse_expr 
------------------
Expressions are a self-contained subset of the SmallC grammar. As such, implementing them first will allow us to build the rest of the language on top of them later. Recall the `expr` type from project 3b:
```
type expr =
  | ID of string
  | Int of int
  | Bool of bool
  | Add of expr * expr
  | Sub of expr * expr
  | Mult of expr * expr
  | Div of expr * expr
  | Pow of  expr * expr
  | Greater of expr * expr
  | Less of expr * expr
  | GreaterEqual of expr * expr
  | LessEqual of expr * expr
  | Equal of expr * expr
  | NotEqual of expr * expr
  | Or of expr * expr
  | And of expr * expr
  | Not of expr
```

The function `parse_expr : token list -> token list * expr` takes a list of tokens and returns a tuple of the remaining tokens and the `expr` that was parsed. Examples in class used a more imperative style with a global reference, but the `parse_expr` and `parse_stmt` functions in this project use a purely functional style where remaining tokens are returned along with the produced AST types. How you choose to use this part of the return value is up to you, but it must satisfy the same property of finally returning all remaining tokens regardless of your design decisions around it.

The (ambiguous) CFG of expressions, from which you should produce a value of `expr` AST type, is as follows:

- Expr -> OrExpr
- OrExpr -> OrExpr `||` OrExpr | AndExpr
- AndExpr -> AndExpr `&&` AndExpr | EqualityExpr
- EqualityExpr -> EqualityExpr EqualityOperator EqualityExpr | RelationalExpr
  - EqualityOperator -> `==` | `!=`
- RelationalExpr -> RelationalExpr RelationalOperator RelationalExpr | AdditiveExpr
  - RelationalOperator -> `<` | `>` | `<=` | `>=`
- AdditiveExpr -> AdditiveExpr AdditiveOperator AdditiveExpr | MultiplicativeExpr
  - AdditiveOperator -> `+` | `-`
- MultiplicativeExpr -> MultiplicativeExpr MultiplicativeOperator MultiplicativeExpr | PowerExpr
  - MultiplicativeOperator -> `*` | `/`
- PowerExpr -> PowerExpr `^` PowerExpr | UnaryExpr
- UnaryExpr -> `!` UnaryExpr | PrimaryExpr
- PrimaryExpr -> *`Tok_Int`* | *`Tok_Bool`* | *`Tok_ID`* | `(` Expr `)`

The transformation of the above ambiguous grammar into a parsable, non-ambiguous, grammar can be found in the addendum. We encourage you to do the transformation yourself and utilize the addendum to check your work and ensure correctness before coding. 

As an example, see how the parser will break down an input mixing a few different operators with different precedence:

### Input:
```
2 * 3 ^ 5 + 4
```

### Output (Stylized to show order):
```
Add(
  Mult(
    Int(2),
    Pow(
      Int(3),
      Int(5))),
  Int(4))
```

Parser Part 2: parse_stmt
------------------
The next step to parsing is to build statements up around your expression parser. When parsing, a sequence of statements should be terminated as a `NoOp`, which you will remember as a do-nothing instruction from the interpreter. Recall the `stmt` type:

```
type stmt =
  | NoOp
  | Seq of stmt * stmt
  | Declare of data_type * string
  | Assign of string * expr
  | If of expr * stmt * stmt
  | While of expr * stmt
  | Print of expr
```

The function `parse_stmt : token list -> token list * stmt` takes a token list as input and returns a tuple of the tokens remaining and the `stmt` that was parsed from the consumed input tokens. The `stmt` type isn't self contained like the `expr` type, and instead refers both to itself and to `expr`; use your `parse_expr` function to avoid duplicate code!

Again, we provide a grammar that is ambiguous and must be adjusted to be parsable by your recursive descent parser:

- Stmt -> Stmt Stmt | DeclareStmt | AssignStmt | PrintStmt | IfStmt | WhileStmt
  - DeclareStmt -> BasicType ID `;`
    - BasicType -> `int` | `bool`
  - AssignStmt -> ID `=` Expr `;`
  - PrintStmt -> `printf` `(` Expr `)` `;`
  - IfStmt -> `if` `(` Expr `)` `{` Stmt `}` ElseBranch
    - ElseBranch -> `else` `{` Stmt `}` | ε
  - WhileStmt -> `while` `(` Expr `)` `{` Stmt `}`

As with the Expression grammar, the transformation to enable the grammar to be parsable can be found in the addendum.

If we expand on our previous example, we can see how the expression parser integrates directly into the statement parser:

### Input:
```
int x;
x = 2 * 3 ^ 5 + 4;
printf(x > 100);
```

### Output (Stylized to show order):
```
Seq(Declare(Int_Type, "x"),
Seq(Assign("x",
  Add(
    Mult(
      Int(2),
      Pow(
        Int(3),
        Int(5))),
    Int(4))),
Seq(Print(Greater(ID("x"), Int(100))), NoOp)))
```

Parser Part 3: parse_main
------------------
The last and shortest step is to have your parser handle the function entry point. This is where `parse_main : token list -> stmt` comes in. This function behaves the exact same way as `parse_stmt`, except for two key semantic details:
- `parse_main` will parse the function declaration for main, not just the body.
- `parse_main` validates that a successful parse terminates in `EOF`. A parse not ending in `EOF` should raise an `InvalidInputException` in `parse_main`. As such, `parse_main` does NOT return remaining tokens, since it validates ensures that the token list is emptied by the parse.

The grammar for this parse is provided here:

- Main ::= `int` `main` `(` `)` `{` Stmt `}` `EOF`

For this slightly modified input to the example used in the previous two sections, the exact same output would be produced:

### Input:
```
int main() {
  int x;
  x = 2 * 3 ^ 5 + 4;
  printf(x > 100);
}
```

The output is the exact same as in the statement parser, but `parse_main` also trims off the function header and verifies that all tokens are consumed.

Project Submission
------------------
You should submit the files `lexer.ml` and `parser.ml` containing your solution. You may submit other files, but they will be ignored during grading. We will run your solution as individual OUnit tests just as in the provided public test file.

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
[str doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html
[semantics document]: semantics.pdf

<!-- These should always be left alone or at most updated -->
[pervasives doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
[git instructions]: ../git_cheatsheet.md
[submit server]: https://submit.cs.umd.edu
[web submit link]: ../common-images/web_submit.jpg
[web upload example]: ../common-images/web_upload.jpg
