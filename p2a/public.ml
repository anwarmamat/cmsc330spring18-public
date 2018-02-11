open OUnit2
open Basics
open TestUtils

let test_divides ctxt = 
  assert_equal true (divides 5 10);
  assert_equal false (divides 3 7);
  assert_equal false (divides 10 5)

let test_gcd ctxt =
  assert_equal 4 (gcd 8 12);
  assert_equal 6 (gcd 54 24);
  assert_equal 10 (gcd 110 200);
  assert_equal 2 (gcd 4 6)

let test_ack ctxt =
  assert_equal 61 (ack 3 3);
  assert_equal 4 (ack 1 2);
  assert_equal 7 (ack 2 2)

let test_second_element ctxt =
  assert_equal 20 (second_element [10; 20; 30]);
  assert_equal (-1) (second_element [])

let test_max_first_three ctxt =
  assert_equal 7 (max_first_three [7; 4; 7]);
  assert_equal 2 (max_first_three [2; 2; 2]);
  assert_equal 10 (max_first_three [10; 0; 1]);
  assert_equal 3 (max_first_three [3; 2; 0])

let test_partial_sum ctxt =
  assert_equal 11 (partial_sum 1 [5;6;7;3]);
  assert_equal 21 (partial_sum 3 [5;6;7;3])

let test_partial_sums ctxt =
  assert_equal [18;5] (partial_sums [2;0] [5;6;7;3]);
  assert_equal [18;21] (partial_sums [2;3] [5;6;7;3])

let test_zip ctxt =
  assert_equal (zip [1;3] [2;4]) [(1,2); (3,4)];
  assert_equal (zip [1;3] [2]) [(1,2)];
  assert_equal (zip [] []) []

let test_index ctxt =
  assert_equal 0 (index 1 [1;2]);
  assert_equal (-1) (index 5 [1;2;3]);
  assert_equal 0 (index 2 [2;2;2;2])

let test_elem ctxt =
  assert_false @@ elem 3 (create_set []);
  assert_true @@ elem 5 (create_set [2;3;5;7;9]);
  assert_false @@ elem 4 (create_set [2;3;5;7;9])

let test_remove ctxt =
  assert_set_equal (create_set []) @@ remove 5 (create_set []);
  assert_set_equal (create_set [2;3;7;9]) @@ remove 5 (create_set [2;3;5;7;9]);
  assert_set_equal (create_set [2;3;5;7;9]) @@ remove 4 (create_set [2;3;5;7;9])

let test_union ctxt =
  assert_set_equal (create_set [2;3;5]) @@ union (create_set []) (create_set [2;3;5]);
  assert_set_equal (create_set [2;3;5;7;9]) @@ union (create_set [2;5]) (create_set [3;7;9]);
  assert_set_equal (create_set [2;3;7;9]) @@ union (create_set [2;3;9]) (create_set [2;7;9])

let test_intersection ctxt =
  assert_set_equal (create_set []) @@ intersection (create_set [2;3;5]) (create_set []);
  assert_set_equal (create_set []) @@ intersection (create_set [3;7;9]) (create_set [2;5]);
  assert_set_equal (create_set [5]) @@ intersection (create_set [2;5;9]) (create_set [3;5;7])

let test_product ctxt =
  assert_set_equal (create_set []) @@ product (create_set []) (create_set [2;3;5]);
  assert_set_equal (create_set [(5,2);(5,5);(7,2);(7,5)]) @@ product (create_set [5;7]) (create_set [2;5]);
  assert_set_equal (create_set [(2,3);(2,9)]) @@ product (create_set [2]) (create_set [3;9])

let test_subset ctxt =
  assert_true @@ subset (create_set [2]) (create_set [2;3;5;7;9]);
  assert_true @@ subset (create_set [3;5]) (create_set [2;3;5;7;9]);
  assert_false @@ subset (create_set [4;5]) (create_set [2;3;5;7;9])

let suite =
  "public" >::: [
    "divides" >:: test_divides;
    "gcd" >:: test_gcd;
    "ack" >:: test_ack;

    "second_element" >:: test_second_element;
    "max_first_three" >:: test_max_first_three;

    "partial_sum" >:: test_partial_sum;
    "partial_sums" >:: test_partial_sums;
    "zip" >:: test_zip;
    "index" >:: test_index;

    "elem" >:: test_elem;
    "subset" >:: test_subset;
    "remove" >:: test_remove;
    "union" >:: test_union;
    "intersection" >:: test_intersection;
    "product" >:: test_product
  ]

let _ = run_test_tt_main suite
