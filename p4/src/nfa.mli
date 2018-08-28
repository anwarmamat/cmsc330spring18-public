(* IMPORTANT: YOU MAY NOT MODIFY THIS FILE!
 * OUR TESTS USE THE ORIGINAL VERSION.
 * YOUR CODE WILL NOT COMPILE IF YOU CHANGE THIS FILE. *)

(* Types *)

type ('q, 's) transition = 'q * 's option * 'q
type ('q, 's) nfa_t = {
  qs : 'q list;
  sigma : 's list;
  delta : ('q, 's) transition list;
  q0 : 'q;
  fs : 'q list;
}

(* These are the signatures of functions you must implement *)

val e_closure : ('q, 's) nfa_t -> 'q list -> 'q list
val move : ('q, 's) nfa_t -> 'q list -> 's option -> 'q list
val nfa_to_dfa : ('q, 's) nfa_t -> ('q list, 's) nfa_t
val accept : ('q, char) nfa_t -> string -> bool
