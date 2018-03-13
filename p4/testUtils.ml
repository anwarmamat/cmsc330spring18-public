open Nfa
open OUnit2

let assert_true x = assert_equal true x;;
let assert_false x = assert_equal false x;;
let assert_pass () = assert_equal true true;;
let assert_fail () = assert_equal false false;;

let string_of_int_list l = Printf.sprintf "[%s]" @@ String.concat "; " @@ List.map string_of_int l;;

let assert_dfa m =
  let nondet = List.fold_left (fun res (q, c, f) -> match c with
  | None -> true
  | Some _ -> let others = List.filter (fun (q', c', f') -> q' = q && c' = c) m.delta in
      res || ((List.length others) > 1)) false m.delta in
  if nondet then assert_failure @@ Printf.sprintf "NFA is not DFA"

(* Helpers for clearly testing the accept function *)
let assert_nfa_accept nfa input =
  if not @@ Nfa.accept nfa input then
    assert_failure @@ Printf.sprintf "NFA should have accept string '%s', but did not" input

let assert_nfa_deny nfa input =
  if Nfa.accept nfa input then
    assert_failure @@ Printf.sprintf "NFA should not have accepted string '%s', but did" input

let assert_nfa_closure nfa ss es =
  let es = List.sort compare es in
  let rcv = List.sort compare @@ Nfa.e_closure nfa ss in
  if not (es = rcv) then
    assert_failure @@ Printf.sprintf "Closure failure: Expected %s, received %s" (string_of_int_list es) (string_of_int_list rcv)

let assert_nfa_move nfa ss mc es =
  let es = List.sort compare es in
  let rcv = List.sort compare @@ Nfa.move nfa ss mc in
  if not (es = rcv) then
    assert_failure @@ Printf.sprintf "Move failure: Expected %s, received %s" (string_of_int_list es) (string_of_int_list rcv)

let assert_regex_string_equiv rxp = assert_equal rxp @@ Regexp.string_to_regexp @@ Regexp.regexp_to_string rxp
