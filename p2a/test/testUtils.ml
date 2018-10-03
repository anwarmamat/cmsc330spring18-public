open OUnit2

let assert_true x = assert_equal true x;;
let assert_false x = assert_equal false x;;

let create_set l =
  let rec create_set_helper acc = function
    | [] -> acc
    | h::t -> create_set_helper (Basics.insert h acc) t
  in
  create_set_helper [] l

let assert_set_equal x y = assert_equal true (Basics.eq x y)
