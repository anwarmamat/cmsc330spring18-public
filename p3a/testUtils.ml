open OUnit2
open Parser
open Utils
open SmallCTypes

(* Assertion wrappers for convenience and readability *)
let assert_true b = assert_equal true b
let assert_false b = assert_equal false b
let assert_succeed () = assert_true true

(* parse utils *)

let input_handler f =
  try
    let _ = f () in assert_failure "Expected InvalidInputException, none received" with
  | InvalidInputException(_) -> assert_succeed ()
  | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected InvalidInputException")

let assert_stmt_fail (s : string) =
  input_handler (fun _ ->
    let toks = Lexer.tokenize s in
    parse_main toks)

let assert_expr_fail s =
  assert_stmt_fail ("int main() { printf(" ^ s ^ "); }")

let assert_ast_equal
    (es : string)
    (output : stmt) : unit =
  let toks = tokenize_from_file es in
  let ast = parse_main toks in
  assert_equal ast output

let create_system_test
    (es : string)
    (output : stmt) : (test_ctxt -> unit) =
  (fun _ -> assert_ast_equal es output)
