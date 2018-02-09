open OUnit2
open Disc

let test_fact ctxt =
  assert_equal 1 (fact 1);
  assert_equal 120 (fact 5)
;;

let test_fact_tr_aux ctxt =
  assert_equal 1 (fact_tr_aux 1 1);
  assert_equal 120 (fact_tr_aux 1 5);
  assert_equal 120 (fact_tr_aux 60 2)
;;

let test_unary ctxt =
  assert_equal "" (unary 0);
  assert_equal "1" (unary 1);
  assert_equal "1111111" (unary 7)
;;

let test_sum_digits ctxt =
  assert_equal 0 (sum_digits 0);
  assert_equal 3 (sum_digits 120)
;;

let test_binary ctxt =
  assert_equal "" (binary 0);
  assert_equal "1" (binary 1);
  assert_equal "10" (binary 2);
  assert_equal "111" (binary 7)
;;

let suite =
  "disc3" >::: [
    "fact" >:: test_fact;
    "fact_tr_aux" >:: test_fact_tr_aux;
    "unary" >:: test_unary;
    "sum_digits" >:: test_sum_digits;
    "binary" >:: test_binary
  ]

let _ = run_test_tt_main suite
