use super::*;

#[test]
fn public_test_substrings() {
    let mut v = substrings("abc");
    v.sort();
    assert_eq!(vec!["a", "ab", "abc", "b", "bc", "c"] , v);
}

#[test]
fn public_test_quicksort() {
    let mut v = [1, 3, 2];
    quicksort(&mut v);
    assert_eq!([1, 2, 3], v);
}

#[test]
fn public_test_get_from_both() {
    let mut a: HashMap<&str, i32> = HashMap::new();
    a.insert("a", 4);
    a.insert("c", 2);

    let mut b: HashMap<&str, i32> = HashMap::new();
    b.insert("b", 4);
    b.insert("c", 2);

    assert_eq!(4, get_from_both(&a, &b, "a"));
    assert_eq!(4, get_from_both(&a, &b, "b"));
    assert_eq!(4, get_from_both(&a, &b, "c"));
    assert_eq!(0, get_from_both(&a, &b, "d"));
}

#[test]
fn public_test_vec2_add() {
    assert_eq!(Vec2 { x: 4., y: 6. }, Vec2 { x: 1., y: 2. } + Vec2 { x: 3., y: 4. });
}
