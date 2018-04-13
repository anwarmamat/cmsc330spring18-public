// Discussion 10 exercises, due 4/13/2018

// HOW TO SUBMIT:
// Upload lib.rs (that's it) via web submission.

// IF YOU ARE USING GRACE: You can download lib.rs on
// https://dav.terpconnect.umd.edu

// YOU CANNOT USE "ruby submit.rb" because I wasn't able to get it to
// work in time. Hopefully it will work for next week's discussion and
// the project.

// Returns the sum of the even integers in the range [i, j).
// sum_evens(0, 6) -> 6 (0 + 2 + 4)
pub fn sum_evens(i: i32, j: i32) -> i32 {
    0
}

// Returns the Euclidean distance between 2-dimensional points a and b.
// The points are represented as 2-tuples of f64s.
// distance((0.0, 0.0), (1.0, 1.0) -> 1.41...
pub fn distance((ax, ay): (f64, f64), (bx, by): (f64, f64)) -> f64 {
    0.0
}

// Returns the sum of the squared elements of arr.
// sum_squares(&[1, 2] -> 5 (1^2 + 2^2)
pub fn sum_squares(arr: &[i32]) -> i32 {
    0
}

// Adds 1 to each element of the array. (Mutates the array.)
// let mut arr: [i32; 3] = [0, 1, 2];
// raise_1(&mut arr)
// (arr is now [1, 2, 3])
pub fn raise_1(arr: &mut [i32]) {

}

// CHALLENGE PROBLEM (UNGRADED)

// Returns the max consecutive 1s in the array.
// consecutive_1s(&[1, 1, 1, 0, 1, 1]) -> 3
pub fn consecutive_1s(arr: &[i32]) -> i32 {
    0
}

#[cfg(test)]
mod public;

