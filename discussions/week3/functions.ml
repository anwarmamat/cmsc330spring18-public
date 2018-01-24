(*
 * Determine the types of the following variables WITHOUT entering them into the OCaml top-level
 *)

let x = [1;2;3];;

let y = [1;2]::[];;

let w = 1.0;;

let s = ["hello"; "there"];;


(*
 * Complete all of the following functions. Helper functions are allowed, but internal
 * let statements are not.
 *)

(*
 * first ls : `a list -> `a
 *      Returns the first element of the list 
 *)
let first ls = failwith "unimplemented" 
;;

(*
 * len ls : 'a list -> int
 *      Returns the length of the list
 *)
let rec len ls = failwith "unimplemented"
;;

(*
 * add_to_list ls n : int list -> int -> int list
 *      Returns ls with n added to every element
 *)
let rec add_to_list ls n = failwith "unimplemented"
;;

(*
 * remove_greater ls n : int list -> int -> int list
 *      Removes all elements greater than n from ls
 *)
let rec remove_greater ls n = failwith "unimplemented" 
;;

(*
 * fib n : int -> int
 *      Calcualte the nth fibonocci number. If you need help with the algo, go here:
 *      https://en.wikipedia.org/wiki/Fibonacci_number
 *)
let rec fib n = failwith "unimplemented"
;;

(**
 * CHALLENGE PROBLEM
 *
 * reverse ls : 'a list -> 'a list
 *      Returns ls, reversed
 **)
let rec reverse ls = failwith "unimplemented"
