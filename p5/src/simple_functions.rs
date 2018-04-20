//! Part 1 - Warmup
//! These are functions to help familiarize yourself with the Rust language.  You have already implemented some of these in
//! your Ocaml projects.  Feel free to copy the logic from your Ocaml functions to Rust.
//!
//! Keep in mind that Rust Vectors, Slices and Arrays cannot be matched in the same way as Ocaml
//! lists, so some things may not translate directly.


/// Returns the value of the Ackermann–Péter function for m and n.
pub fn ack(m: i32, n: i32) -> i32 {
    0
}

/// Returns the sum of the values from index 0 to index i (0-indexed) of lst inclusive. If i is
/// greater than greatest index of list, return the sum of all elements of list. 
///
/// It might be helpful to use the enumerate method of the Iterator trait.
pub fn partial_sum(i: usize, is: &[i32]) -> i32 {
    0
}

/// Returns the mean of elements in lst. If the list is empty, return None. 
///
/// It might be helpful to use the fold method of the Iterator trait.
pub fn mean(lst: &[f64]) -> Option<f64> {
    None
}

/// Performs a simple binary search, returning the index of the element if it was found, or None if not found
pub fn bsearch<T: Eq + PartialOrd> (lst: &[T], ele: &T) -> Option<usize> {
    None 
}

/// We have a CSV of course information. The CSV has many lines that are formatted as "<Deptartment>,<CourseNumber>,<RoomNumber>,<DaysOfWeek>".
/// A str containing all of the CSV file, Calculate the number of courses being offered in each department, in each room, and at each time. 
/// Write the function get_course_data that does these calculations, and stores the results in three hashes that map departments, rooms, and times to number of occurrences.
/// Return these hashes in a tuple
///
/// For context, here is how the function will be used:
/// use std::io::Read;
/// use std::fs::File;
/// use std::path::Path;
/// fn process_csv<P: AsRef<Path>>(filename: P) -> () {
///     let mut file = File::open(filename).unwrap();
///     let mut buf = String::new();
///     file.read_to_string(&mut buf);
///     let (depthash, roomhash, timehash) = get_course_data(buf.as_str());
///     // run some tests >:)
/// }

use std::collections::HashMap;
pub fn get_course_data(csv_data: &str) -> (HashMap<&str,usize>,HashMap<&str,usize>,HashMap<&str,usize>)  {
    (HashMap::new(),HashMap::new(),HashMap::new())
}
