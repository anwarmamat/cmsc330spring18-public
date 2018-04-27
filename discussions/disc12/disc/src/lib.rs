// Discussion 12 exercises, ungraded

use std::mem::swap;
use std::rc::Rc;

// Given a list of list of integers, return the sum. Use map and fold.
// sum_arr_arr(&[&[1, 2], &[3]] -> 6
pub fn sum_arr_arr(arr: &[&[i32]]) -> i32 {
    // IMPLEMENT
    0
}

#[derive (Debug, PartialEq)]
enum List<T> {
    Nil,
    Cons(T, Box<List<T>>)
}

use List::{Nil, Cons};

impl <T> List<T> {
    pub fn new() -> Self {
        Nil
    }

    // Adds an element to the end of the list.
    pub fn add(&mut self, e: T) {
        // IMPLEMENT
    }

    // Returns a Vec representation of the list.
    pub fn vec(&self) -> Vec<&T> {
        let mut out_vec = Vec::new();
        self.vec_aux(&mut out_vec);
        out_vec
    }

    fn vec_aux<'a>(&'a self, out_vec: &mut Vec<&'a T>) {
        // IMPLEMENT
    }
}

impl <'a, T> IntoIterator for &'a List<T> {
    type Item = &'a T;
    type IntoIter = ::std::vec::IntoIter<&'a T>;

    // Returns an iterator for the list.
    fn into_iter(self) -> Self::IntoIter {
        self.vec().into_iter()
    }
}

#[derive (Debug, PartialEq)]
struct Texture {
    id: i32,
}

#[derive (Debug, PartialEq)]
struct Tree {
    texture: Rc<Texture>,
}

fn rc_demo() -> (i32, i32) {
    let tree1;
    let tree2;
    {
        let texture1 = Rc::new(Texture { id: 1 });
        let texture2 = Rc::new(Texture { id: 2 });
        tree1 = Tree { texture: Rc::clone(&texture1) };
        tree2 = Tree { texture: Rc::clone(&texture1) };
    }
    (tree1.texture.id, tree2.texture.id)
}


#[cfg(test)]
mod public;
