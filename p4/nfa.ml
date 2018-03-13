open Sets

(*********)
(* Types *)
(*********)

type ('q, 's) transition = 'q * 's option * 'q
type ('q, 's) nfa_t = {
  qs : 'q list;
  sigma : 's list;
  delta : ('q, 's) transition list;
  q0 : 'q;
  fs : 'q list;
}

(*********************)
(* Utility Functions *)
(*********************)

let explode s =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) []

let rec fix comp f x0 =
  let next = f x0 in
  if comp x0 next then x0 else fix comp f next

(****************)
(* Part 1: NFAs *)
(****************)

let move m qs s = failwith "unimplemented"

let e_closure m qs = failwith "unimplemented"

let accept m str = failwith "unimplemented"

let nfa_to_dfa m = failwith "unimplemented"
