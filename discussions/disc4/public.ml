open OUnit2
open Disc

let test_add_x ctxt =
  assert_equal [] (add_x 2 []);
  assert_equal [3; 4; 5] (add_x 2 [1; 2; 3])
;;

let test_concat_strings ctxt =
  assert_equal "" (concat_strings []);
  assert_equal "bulbasaursquirtlecharmander" (concat_strings ["bulbasaur"; "squirtle"; "charmander"])
;;

let test_firsts ctxt =
  assert_equal [] (firsts []);
  assert_equal [1; 3; 5] (firsts [(1, 2); (3, 4); (5, 6)])
;;

let test_apply_all ctxt =
  assert_equal 1 (apply_all 1 []);
  assert_equal (-4) (apply_all 1 [(fun x -> x + 1); (fun x -> x * 2); (fun x -> x * (-1))])
;;

let test_map ctxt =
  assert_equal [] (map float_of_int []);
  assert_equal [1.0; 2.0; 3.0] (map float_of_int [1; 2; 3])
;;

let suite =
  "disc" >::: [
    "add_x" >:: test_add_x;
    "concat_strings" >:: test_concat_strings;
    "firsts" >:: test_firsts;
    "apply_all" >:: test_apply_all;
    "map" >:: test_map
  ]

let _ = run_test_tt_main suite
