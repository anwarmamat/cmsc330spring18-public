//! Part 4 - traits
//!
//! Below, we have defined a trait for a queue data structure.  Implement this trait for Vec<T>

pub trait Queue<T> {
    // Add an element to the back of the queue
    fn enqueue(&mut self, ele: T) -> ();
    // Get the element from the front of the queue without removing it.  If the queue is empty, return None
    fn peek(&self) -> Option<&T>;
    // Get the element from the front of the queue and removes it.  If the queue is empty, return None
    fn poll(&mut self) -> Option<T>;
}



impl <T> Queue<T> for Vec<T> {

    fn enqueue(&mut self, ele: T) -> () {
        ()
    }

    fn peek(&self) -> Option<&T> {
        None
    }

    fn poll(&mut self) -> Option<T> {
        None
    }
}
