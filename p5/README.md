# Project 5: Rust

CMSC 330, Spring 2018

Due: 4/30

P/R/S: 48/52/0

Ground Rules
---------------------------
**This is an individual assignment. You must work on this project alone.**

For this project you are allowed to use the library functions found in `std`, including `Vec`, `String`, `collections::HashMap`, and `Box`.

Introduction
------------
In this project, you will implement various functions and data structures to help you understand the core concepts of Rust.  

Project Files
-------------
To begin this project, you will need to commit any uncommitted changes to your local branch and pull updates from the git repository. [Click here for directions on working with the Git repository.][git instructions] The following are the relevant files:

* Rust Files
    * __lib.rs__:  This file describes the structure of the Rust library you are making.  You should not need to modify it.
    * __simple_functions.rs__: These are the functions for Part 1, to help you get used to the language.
    * __fixup.rs__: This file contains functions that do not compile, and it will be your job to fix them.
    * __bst.rs__: This file contains the skeleton for a binary search tree, which you must implement.
    * __queue.rs__: This file contains the skeleton of an implementation of a queue for Vec
    * __public.rs__: These are the public tests.  Feel free to write your own.
    * __public.csb__: This contains data for one of the functions from part 2.
* Submission Scripts and Other Files
    * __submit.rb__: Execute this script to submit your project to the submit server.
    * __submit.jar and .submit__: These files are used by the ruby file above, do not worry about them.

Compilation and Tests
---------------------
In order to compile the project, simply run `cargo build`.  To test, run `cargo test` in the root directory of the project.  The tests won't run if any part of the
project does not compile.

Installing Rust and Cargo
-------------------------
If you are working in grace, run `module avail rust` every time you log in.

If you are working in a linux environment (that includes C9, Mac, and Bash for Windows 10), just run `curl https://sh.rustup.rs -sSf | sh` in the terminal.

If you are working in Windows and CMD, then go to `https://www.rust-lang.org/en-US/install.html` and download `rustup-init.exe` and run it from CMD

Part 1 - Warmup
---------------
These are functions that you have already implemented in past Ocaml projects.  
This is to help familiarize yourself with the Rust language.  Feel free to copy the logic from your Ocaml functions to Rust.
Keep in mind that Rust Vectors, Slices and Arrays cannot be matched in the same way as Ocaml lists, so some things may not translate directly.

**ack**
* **Type:** `fn ack(m: i32, n: i32) -> i32`
* **Description:** Returns the value of the Ackermann–Péter function for m and n.

**partial_sum**
* **Type:** `fn partial_sum (i: usize, is: &[i32]) -> i32`
* **Description:** Returns the sum of the values from index 0 to index i (0-indexed) of lst inclusive. If i is greater than greatest index of list, return the sum of all elements of list.  It might be helpful to use the enumerate method of the Iterator trait.

**mean**
* **Type:** `fn mean(lst: &[f64]) -> Option<f64>`
* **Description:** Returns the mean of elements in lst. If the list is empty, return None. It might be helpful to use the fold method of the Iterator trait.

**bsearch**
* **Type:** `fn bsearch<T: Eq + PartialOrd> (lst: &[T], ele: T) -> Option<usize>`
* **Description:** A simple binary search of a slice.  Returns the index of the element if it is present, and None if it is not present.  You may not use the built in bsearch method of slices or vectors, it must be your own work!


**get_course_data**
* **Type:** `fn get_high_scorers(csv_data: &str) -> (HashMap<&str,usize>,HashMap<&str,usize>,HashMap<&str,usize>) `
* **Description:** We have a CSV of course information.  The CSV has many lines that are formatted as "<Deptartment>,<CourseNumber>,<RoomNumber>,<DaysOfWeek>".  A str containing all of the CSV file, Calculate the number of courses being offered in each department, in each room, and at each time.  Write the function get_course_data that does these calculations, and stores the results in three hashes that map departments, rooms, and times to number of occurrences.  Return these hashes in a tuple.

If the data file looks like this:
```
CMSC,131,1115,MWF
CMSC,216,2115,TuTh
MATH,240,0105,MWF
```

Then the hashes should look like this:
```
(
    {
        "CMSC": 2,
        "MATH": 1
    },
    {
        "1115": 1,
        "2115": 1,
        "0105": 1
    },
    {
        "MWF": 2,
        "TuTh: 1
    }
)
```

For context, here is how this function will be used:
```
use std::io::Read;
use std::fs::File;
use std::path::Path;
fn process_csv<P: AsRef<Path>>(filename: P) -> () {
    let mut file = File::open(filename).unwrap();
    let mut buf = String::new();
    file.read_to_string(&mut buf);
    let (depthash, roomhash, timehash) = get_high_scorers(buf.as_str());
    // process hashes however you want, but you can't return them!
}
```

Part 2 - Ownership, Borrowing, and Lifetimes
--------------------------------------------
The code for first five problems in this part is already given, but does not compile.  You must
fix the code and/or the function signatures so that it compiles.  You may not use the .clone()
method anywhere, unless otherwise specified

**palindromify**
* **Type:** `fn palindromify(lst: &Vec<i32>) -> () `
* **Description:** Takes a vector and adds all of its elements to itself in reverse order.  So [1,2,3] becomes [1,2,3,3,2,1]


**rotate**
* **Type:** `fn rotate(lst: &[i32]) -> &Vec<i32>`
* **Description:** Takes all of the elements and creates a new vector that takes all the elements of the original and rotates them, so the first becomes the last, the second becomes first, and so on. Thus, [1,2,3,4] becomes [2,3,4,1]


**get_match**
* **Type:** `fn get_match(words: &str, match_word: &str) -> Option<&str>`
* **Description:** checks if any of the words in the first string matches the second string, returns the slice of the string that matched if there was a match, or None if there was no match


**squared_cubed_sum** 
* **Type:** `fn squared_cubed_sum(lst: Vec<i32>) -> i32`
* **Description:** Finds the sum of squares of all the elements, and the sum of all the cubes, and adds these values. You must call squared_sum and cubed_sum in squared_cubed_sum, and not do all the logic in squared_cubed_sum.

**append_values**
* **Type:** `fn append_values(hash: &mut HashMap<String, String>, key1: &str, key2: &str, to_append: &str) -> ()`
* **Description:** This function modifies two values from a hashmap associated with key1 and key2, and appends the string to_append to them.  You are guaranteed the keys exist in the hashmap.


Part 3 - Traits
---------------

we have defined the following trait:

```
trait Queue<T> {
    // Add an element to the back of the queue
    fn enqueue(&mut self, ele: T) -> ()
    // Get the element from the front of the queue without removing it.  If the queue is empty, return None
    fn peek(&self) -> Option<&T>
    // Get the element from the front of the queue and removes it.  If the queue is empty, return None
    fn poll(&mut self) -> Option<T>
}
```

implement this trait for Vec<T>


Part 4 - Binary Search Tree
---------------------------

You are given the definition of a generic BST:

```
enum BST<T: Eq + PartialOrd> {
    Leaf,
    Node(T, Box<BST<T>>, Box<BST<T>>)
}
```

implement the following functions for this BST type:

**insert**
* **Type:** `fn insert(&mut self, ele: T) -> () `
* **Description:** Inserts `ele` into the BST.  For this, you may want to utilize std::mem::swap.  If the data of a node is equal to `ele`, then simply insert `ele` to the right.

**mem**
* **Type:** `fn mem(&self, ele: T) -> bool`
* **Description:** Checks whether `ele` is in the BST

**to_list**
* **Type:** `fn to_list(&self) -> Vec<&T>.  `
* **Description:** Converts the BST into a sorted Vec. For this, you may want to implement a helper function that uses an [inorder traversal][wikipedia inorder traversal].

**IntoIter**
implement the `IntoIterator` trait for `&BST`, where `Item = &T` and `IntoIter = std::vec::IntoIter` (meaning you want to use a Vec to implement this).
The `IntoIterator` trait requires you to implement the `into_iter` function, which returns `IntoIter`.

`IntoIterator` is a trait that converts the given type into an `Iterator`, which can then be used in a for loop, folded or mapped over, etc.  Here is some example usage:

```
let mut bst = BST::new();
bst.insert(5);
bst.insert(2);
bst.insert(7);
bst.insert(1);

for i in &bst { // Works because &BST implements IntoIterator
    println!("{}", i + 1); 
}

let sum = &bst.into_iter().fold(0, |a,h| a + h);
```

Project Submission
------------------
You should submit the files `simple_functions.rs`, `fixup.rs`, `bst.rs`, and `queue.rs`  containing your solution. You may submit other files, but they will be ignored during grading. We will run your solution as individual tests just as in the provided public test file.  **No tests will pass on the submit server if the project does not compile!**

Be sure to follow the project description exactly! Your solution will be graded automatically, so any deviation from the specification will result in lost points.

You can submit your project in two ways:

* Submit your files directly to the [submit server][submit server] by clicking on the submit link in the column next to the project number. Then, use the submit dialog to submit all your files. Select your file using the "Browse" button, then press the "Submit project!" button. You do not need to put it in a zip file.
  ![Upload your file][web upload example]
* Submit directly by executing a the submission script on a computer with Java and network access. Included in this project are the submission scripts and related files listed under Project Files. These files should be in the directory containing your project. From there you can either execute `ruby submit.rb` or run the command `java -jar submit.jar` directly (this is all submit.rb does).

No matter how you choose to submit your project, make sure that your submission is received by checking the [submit server][submit server] after submitting.

Academic Integrity
------------------
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will** be submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.


[git instructions]: ../git_cheatsheet.md
[wikipedia inorder traversal]: https://en.wikipedia.org/wiki/Tree_traversal#In-order
[submit server]: submit.cs.umd.edu
[web submit link]: image-resources/web_submit.jpg
[web upload example]: image-resources/web_upload.jpg
