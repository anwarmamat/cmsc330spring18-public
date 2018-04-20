//! Part 3 - Binary Search Tree
//! Here is the definition of a generic BST.  Implement the functions in the impl block

#[derive(PartialEq, Debug)] // Do not remove this line or you will fail tests
pub enum BST<T: Eq + PartialOrd> {
    Leaf,
    Node(T, Box<BST<T>>, Box<BST<T>>)
}

impl <T: Eq + PartialOrd> BST<T> {
    /// Returns an empty BST
    pub fn new() -> Self {
        BST::Leaf
    }

    /// Inserts the given element into the BST
    pub fn insert(&mut self, ele: T) -> () {
        ()
    }

    /// Checks if the given element is in the BST
    pub fn mem(&self, ele: &T) -> bool {
        false
    }

    /// Converts the BST to a sorted list of elements.  You may want to use a helper for this one.
    pub fn to_list(&self) -> Vec<&T> {
        Vec::new()
    }
}

/// Now mplement the IntoIterator trait for &BST, where Item = &T and IntoIter = std::vec::IntoIter
impl <'a, T: Eq + PartialOrd> IntoIterator for &'a BST<T> {
    type Item = &'a T;
    type IntoIter = ::std::vec::IntoIter<&'a T>;
    fn into_iter(self) -> Self::IntoIter {
        Vec::new().into_iter()
    }
}

