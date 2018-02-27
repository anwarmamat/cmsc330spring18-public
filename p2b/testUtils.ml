open OUnit2

let assert_true x = assert_equal true x;;
let assert_false x = assert_equal false x;;
let assert_pass () = assert_equal 0 0;;
let assert_fail () = assert_equal 0 1;;
