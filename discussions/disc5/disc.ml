(*
  Discussion 5 problems
  Upload this to the submit server by Friday 23rd.
  It's graded for correctness.
*)

(* You can use these functions for the following problems. *)

let rec map f l = 
  match l with
  | [] -> []
  | h :: t -> (f h) :: (map f t)
;;

let rec foldl f acc l = 
  match l with
  | [] -> acc
  | h :: t -> foldl f (f acc h) t
;;

(*
  name: sum_list_list
  type: int list list -> int
  desc: Returns the sum of the ints in the lists in l.

  sum_list_list [[]; [1]; [2; 3]] -> 6
*)

let sum_list_list l =
  failwith "unimplemented"
;;

(*
  name: full_names
  type: name_record list -> string list
  desc: Returns string representations of the name_records in l.

  full_names [
    { first = "Anwar"; middle = None; last = "Mamat" };
    { first = "Michael"; middle = Some "William"; last = "Hicks" }
  ]
  -> ["Anwar Mamat"; "Michael William Hicks"]
*)

type name_record = { first: string; middle: string option; last: string };;

let full_names l =
  failwith "unimplemented"
;;

(*
  name: sum_vectors
  type: vector list -> vector
  desc: Returns the sum of the vectors in l.

  sum_vectors [{ x = 1; y = 2 }; { x = 3; y = 4 }] -> { x = 4; y = 6 }
*)

type vector = { x: int; y: int };;

let sum_vectors l =
  failwith "unimplemented"
;;

(*
  name: sum_leaves
  type: tree -> int
  desc: Returns the sum of the leaves of t.

  sum_leaves (Node (Leaf 1, Node (Leaf 2, Leaf 3))) -> 6
*)

type tree =
| Node of tree * tree
| Leaf of int

let rec sum_leaves t =
  failwith "unimplemented"
;;

(* Ungraded optional problem *)

(*
  name: is_balanced
  type: tree -> bool
  desc: Returns whether t is balanced (has uniform height).

  is_balanced (Node (Leaf 1, Node (Leaf 2, Leaf 3))) -> false
  is_balanced (Node (Node (Leaf 1, Leaf 2), Node (Leaf 3, Leaf 4))) -> true
*)

let is_balanced t =
  failwith "unimplemented"
;;

