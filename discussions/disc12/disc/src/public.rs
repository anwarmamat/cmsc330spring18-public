use super::*;

#[test]
fn public_test_sum_arr_arr() {
    assert_eq!(0, sum_arr_arr(&[]));
    assert_eq!(18, sum_arr_arr(&[&[1, 2, 3], &[1, 2, 3], &[1, 2, 3]]));
}

#[test]
fn public_test_list_add() {
    let mut l = List::new();
    l.add(1);
    l.add(2);
    assert_eq!(Cons(1, Box::new(Cons(2, Box::new(Nil)))), l);
}

#[test]
fn public_test_list_vec() {
    let mut l = List::new();
    l.add(1);
    l.add(2);
    assert_eq!(vec![&1, &2], l.vec());
}

#[test]
fn public_test_rc_demo() {
    assert_eq!((1, 1), rc_demo());
}
