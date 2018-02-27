open OUnit2
open Disc

let test_sum_list_list ctxt =
  assert_equal 0 (sum_list_list []);
  assert_equal 6 (sum_list_list [[]; [1]; [2; 3]]);
  assert_equal 4 (sum_list_list [[-1; 1]; [-2; 3]; [-5; 8]])
;;

let test_full_names ctxt =
  assert_equal [] (full_names []);
  assert_equal ["Anwar Mamat"; "Michael William Hicks"] (full_names [{ first = "Anwar"; middle = None; last = "Mamat" }; { first = "Michael"; middle = Some "William"; last = "Hicks" }])
;;

let test_sum_vectors ctxt =
  assert_equal { x = 0; y = 0 } (sum_vectors []);
  assert_equal { x = 4; y = 6 } (sum_vectors [{ x = 1; y = 2 }; { x = 3; y = 4 }])
;;

let test_sum_leaves ctxt =
  assert_equal 0 (sum_leaves (Leaf 0));
  assert_equal 6 (sum_leaves (Node (Leaf 1, Node (Leaf 2, Leaf 3))))
;;

let test_is_balanced ctxt =
  assert_equal true (is_balanced (Leaf 0));
  assert_equal false (is_balanced (Node (Leaf 1, Node (Leaf 2, Leaf 3))));
  assert_equal true (is_balanced (Node (Node (Leaf 1, Leaf 2), Node (Leaf 3, Leaf 4))))
;;

let suite =
  "public" >::: [
    "sum_list_list" >:: test_sum_list_list;
    "full_names" >:: test_full_names;
    "sum_vectors" >::  test_sum_vectors;
    "sum_leaves" >:: test_sum_leaves;
    "is_balanced" >:: test_is_balanced
  ]

let _ = run_test_tt_main suite
