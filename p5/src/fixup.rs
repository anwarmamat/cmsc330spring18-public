//! Part 2 - Ownership, Borrowing, and Lifetimes
//! The code for first five problems in this part is already given, but does not compile.  You must
//! fix the code and/or the function signatures so that it compiles.  You may not use the .clone()
//! method anywhere, unless otherwise specified

/// Takes a vector and adds all of its elements to itself in reverse order. So [1,2,3] becomes [1,2,3,3,2,1]
pub fn palindromify(lst: &Vec<i32>) -> () {
    for x in (0..lst.len()).rev() {
        lst.push(lst[i])
    };
}

/// Takes all of the elements of the given slice and creates a new vector.
/// The new vector takes all the elements of the original and rotates them, so the first becomes the last, the second becomes first, and so on.
/// Thus, [1,2,3,4] becomes [2,3,4,1]
pub fn rotate(lst: &[i32]) -> &Vec<i32> {
    let mut res = Vec::new();
    for i in lst.iter() {
        res.push(i);
    }
    res.push(res.remove(0));
    &res
}

/// Checks if any of the words in the first string matches the second string.
/// Returns the slice of the string that matched if there was a match, or None if there was no match
pub fn get_match(words: &str, match_word: &str) -> Option<&str> {
    for s in words.split_whitespace() {
        if s == match_word {
            return Some(s)
        }
    }
    None
}

/// Finds the sum of squares of all the elements, and the sum of all the cubes, and adds these values.
/// You must call squared_sum and cubed_sum in squared_cubed_sum, and not do all the logic in squared_cubed_sum.
fn squared_sum(lst: Vec<i32>) -> i32 {
    lst.iter().map(|x| x*x).fold(0,|a,h| a + h)    
}

fn cubed_sum(lst: Vec<i32>) -> i32 {
    lst.iter().map(|x| x*x*x).fold(0,|a,h| a + h)    
}

pub fn squared_cubed_sum(lst: Vec<i32>) -> i32 {
    let sq = squared_sum(lst);
    let cube = cubed_sum(lst);
    sq + cube
}

use std::collections::HashMap;
/// This function modifies two values from a hashmap associated with key1 and key2, and appends the string to_append to both values.
pub fn append_values(hash: &mut HashMap<String, String>, key1: &str, key2: &str, to_append: &str) -> () {
      let s1 = hash.get_mut(key1).unwrap();
      let s2 = hash.get_mut(key2).unwrap();
      s1.push_str(to_append.to_owned().as_str());
      s2.push_str(to_append.to_owned().as_str());
}

