extern crate p5;

use p5::simple_functions::{ack, partial_sum, mean, bsearch, get_course_data};

#[test]
fn public_test_ack() {
    assert_eq!(61, ack(3,3));
    assert_eq!(4, ack(1,2));
    assert_eq!(7, ack(2,2));
}

#[test]
fn public_test_partial_sum() {
    assert_eq!(11, partial_sum(1, &vec![5,6,7,3]));
    assert_eq!(21, partial_sum(3, &vec![5,6,7,3]));
}

#[test]
fn public_test_mean() {
    assert_eq!(Some(5.25),mean(&vec![5.0,6.0,7.0,3.0]));
    assert_eq!(Some(6.0),mean(&vec![5.0,6.0,7.0]));
    assert_eq!(Some(6.0),mean(&vec![5.0,7.0]));
    assert_eq!(Some(7.0),mean(&vec![3.0,5.0,8.0,10.0,9.0]));
    assert_eq!(Some(3.0),mean(&vec![3.0]));
}

use p5::fixup::{palindromify, rotate, get_match, squared_cubed_sum, append_values};

#[test]
fn public_test_palindromify() {
    let mut v1 = vec![1,2,3,4];
    let mut v2 = vec![5,4,3,2,1];

    palindromify(&mut v1);
    palindromify(&mut v2);
    assert_eq!(vec![1,2,3,4,4,3,2,1], v1);
    assert_eq!(vec![5,4,3,2,1,1,2,3,4,5], v2);
}

#[test]
fn public_test_rotate() {
    let v1 = vec![1,2,3,4];
    let v2 = vec![5,4,3,2,1];

    assert_eq!(vec![2,3,4,1], rotate(&v1));
    assert_eq!(vec![4,3,2,1,5], rotate(&v2));
}

#[test]
fn public_test_get_match() {
    let s1 = "This is a sentence";
    let s2 = "hello world!";

    assert_eq!(Some("is"), get_match(s1, "is"));
    assert_eq!(Some("hello"), get_match(s2, "hello"));
}

#[test]
fn public_test_squared_cubed_sum() {
    assert_eq!(150, squared_cubed_sum(vec![5]));
    assert_eq!(828, squared_cubed_sum(vec![6,8]));
    assert_eq!(750, squared_cubed_sum(vec![5,5,5,5,5]));
}

use std::collections::HashMap;
#[test]
fn public_test_append_values() {
    let mut map = HashMap::new(); 
    for i in 0..10 {
        map.insert(i.to_string(), (i*10).to_string());
    };
    append_values(&mut map, "3", "6", "Hello");
    append_values(&mut map, "3", "9", "World");
    append_values(&mut map, "4", "7", "foo");

    assert_eq!(map.get("3").expect("Expected Some, got None"), "30HelloWorld");
    assert_eq!(map.get("4").expect("Expected Some, got None"), "40foo");
    assert_eq!(map.get("6").expect("Expected Some, got None"), "60Hello");
    assert_eq!(map.get("7").expect("Expected Some, got None"), "70foo");
    assert_eq!(map.get("9").expect("Expected Some, got None"), "90World");
}

#[test]
fn public_test_bsearch() {
    assert_eq!(Some(3), bsearch(&vec![1,3,5,13,56,78,100], &13));
    assert_eq!(Some(6), bsearch(&vec![1,3,5,13,56,78,100,800,15000,1000000], &100));
    assert_eq!(Some(8), bsearch(&vec![1,3,5,7,9,11,13,15,17,19], &17));
}

use std::io::Read;
use std::fs::File;
#[test]
fn public_test_get_course_data() {
    let mut file = File::open("./tests/public.csv").unwrap();
    let mut buf = String::new();
    let _res = file.read_to_string(&mut buf);
    let (depthash, roomhash, timehash) = get_course_data(buf.as_str());
    assert_eq!(6, *depthash.get("ENGL").unwrap());
    assert_eq!(8, *depthash.get("ENEE").unwrap());
    assert_eq!(4, *depthash.get("CMSC").unwrap());
    assert_eq!(8, *roomhash.get("2342").unwrap());
    assert_eq!(6, *roomhash.get("1115").unwrap());
    assert_eq!(4, *roomhash.get("1101").unwrap());
    assert_eq!(9, *timehash.get("WF").unwrap());
    assert_eq!(7, *timehash.get("TuTh").unwrap());
}

use p5::bst::BST;
#[test]
fn public_test_bst_insert() {
    let mut bst = BST::new();
    bst.insert(5);
    bst.insert(10);
    bst.insert(1);
    bst.insert(7);
    bst.insert(11);
    assert_eq!(BST::Node(5, 
                         Box::new(BST::Node(1, 
                                            Box::new(BST::Leaf),
                                            Box::new(BST::Leaf)
                                            )),
                         Box::new(BST::Node(10,
                                            Box::new(BST::Node(7,
                                                               Box::new(BST::Leaf),
                                                               Box::new(BST::Leaf)
                                                               )),
                                            Box::new(BST::Node(11,
                                                               Box::new(BST::Leaf),
                                                               Box::new(BST::Leaf)
                                                               ))
                                            ))
                         ), bst);

}

#[test]
fn public_test_bst_mem() {
   let bst = BST::Node(5, 
                         Box::new(BST::Node(1, 
                                            Box::new(BST::Leaf),
                                            Box::new(BST::Leaf)
                                            )),
                         Box::new(BST::Node(10,
                                            Box::new(BST::Node(7,
                                                               Box::new(BST::Leaf),
                                                               Box::new(BST::Leaf)
                                                               )),
                                            Box::new(BST::Node(11,
                                                               Box::new(BST::Leaf),
                                                               Box::new(BST::Leaf)
                                                               ))
                                            ))
                         );
   assert!(bst.mem(&1));
   assert!(bst.mem(&5));
   assert!(bst.mem(&10));
   assert!(bst.mem(&7));
   assert!(bst.mem(&11));
   assert!(!bst.mem(&12));
   assert!(!bst.mem(&0));
}

#[test]
fn public_test_bst_to_list() {
    let mut bst = BST::new();
    bst.insert(50);
    bst.insert(10);
    bst.insert(100);
    bst.insert(101);
    bst.insert(-1);
    bst.insert(-12312);
    bst.insert(0);
    assert_eq!(vec![&-12312,&-1,&0,&10,&50,&100,&101], bst.to_list());
}

#[test]
fn public_test_bst_iter() {
    let mut bst = BST::new();
    bst.insert(50);
    bst.insert(10);
    bst.insert(100);
    bst.insert(101);
    bst.insert(-1);
    bst.insert(-12312);
    bst.insert(0);
    
    assert_eq!(7, bst.into_iter().count());
    assert_eq!(-12052, bst.into_iter().fold(0, |a,h| a + h));
    assert_eq!((true,101), bst.into_iter().fold((true, -100000), |(b,l),h| (b && (l < *h),*h)));
                
}

use p5::queue::Queue;

#[test]
fn public_test_queue() {
    let mut q = Vec::new();

    q.enqueue(5);
    q.enqueue(1);
    q.enqueue(3);
    q.enqueue(4);

    assert_eq!(Some(&5), q.peek());
    assert_eq!(Some(5), q.poll());
    assert_eq!(Some(&1), q.peek());
    assert_eq!(Some(1), q.poll());
    assert_eq!(Some(&3), q.peek());
    assert_eq!(Some(3), q.poll());
    assert_eq!(Some(&4), q.peek());
    assert_eq!(Some(4), q.poll());
}
