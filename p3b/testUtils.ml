open OUnit2
open Utils
open Eval
open Types

(* Assertion wrappers for convenience and readability *)
let assert_true b = assert_equal true b
let assert_false b = assert_equal false b
let assert_succeed () = assert_true true

(* Constants pertaining to error case tests *)
let stmt_env : environment = [("x", Int_Val(1)); ("p", Bool_Val(false))]
let expr_env : environment = stmt_env @ [("y", Int_Val(6)); ("q", Bool_Val(true))]

let equiv_environments (xs : environment) (ys : environment) : bool =
  (prune_env xs) = (prune_env ys)

let assert_stmt_success
    ?output:(output="")
    (env : environment)
    (finEnv : environment)
    (es : string) : unit = 

  let s = parse_from_string es in

  flush_print_buffer ();
  assert_true (equiv_environments (eval_stmt env s) finEnv);
  assert_buffer_equal output

let create_system_test
    ?output:(output="")
    (env : environment)
    (finEnv : environment)
    (es : string) : (test_ctxt -> unit) =
  (fun _ -> assert_stmt_success env finEnv (read_from_file es)  ~output:output)

let type_handler f =
  try
    let _ = f () in assert_failure "Expected TypeError, none received" with
  | TypeError(_) -> assert_succeed ()
  | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected TypeError")

let declaration_handler f =
  try
    let _ = f () in assert_failure "Expected DeclareError, none received" with
  | DeclareError(_) -> assert_succeed ()
  | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected DeclareError")

let div_by_zero_handler f =
  try
    let _ = f () in assert_failure "Expected DivByZeroError, none received" with
  | DivByZeroError -> assert_succeed ()
  | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected DivByZeroError")

type expected_exception = TypeExpect | DeclareExpect | DivByZeroExpect

let assert_eval_fail env ast expect parse_fun eval_fun =
  let e = parse_fun ast in
  let expect_function = begin match expect with 
    | TypeExpect -> type_handler
    | DeclareExpect -> declaration_handler
    | DivByZeroExpect -> div_by_zero_handler
  end in
  expect_function (fun () -> eval_fun env e)

let assert_expr_fail ?expect:(expect=TypeExpect) env es =
  assert_eval_fail env es expect parse_expr_from_string eval_expr

let assert_stmt_fail ?expect:(expect=TypeExpect) env smt =
  assert_eval_fail env smt expect parse_stmt_from_string eval_stmt
