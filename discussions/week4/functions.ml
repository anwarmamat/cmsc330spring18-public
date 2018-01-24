(*
 * Complete the following functions. No library functions are allowed except for fold_left
 * and map. Helper functions are allowed.
 *)

(**************** Lists, Tuples, and Records ******************)

(*
 * append l n : 'a list -> 'a list -> 'a list
 *      Appends list n to the end of list l
 *)

let rec append l n = failwith "unimplemented"
;;


(*
 * runlength l : 'a list -> ('a * int) list
 *      Returns the run length encoding of list l
 *
 *      Ex: runlength [1;1;2;2;1;3;3] [] -> [(1,2);(2,2);(1,1);(3,2)]
 *)

let rec runlength l = failwith "unimplemented"
;;


(*
 * This type represents an edge in a graph
 *)
type edge = { src : int; dst : int }
;;

(*
 * dests g n : edge list -> int -> int list
 *      Returns a list of all of the nodes to which node n
 *      has an edge
 *)

let rec dests g n = failwith "unimplemented"
;;


(***************** Higher Order Functions *****************)

(*
 * squaresum l : int list -> int list
 *      Returns the sum of the squares of every integer in
*       list l
 *
 *)

let squaresum l = failwith "unimplemented"
;;


(*
 * compose fl x : (int -> int) list -> int -> int
 *      Returns the composition of all functions in fl
 *      applied to x in reverse order, i.e., f(g(h(x))
 *)

let compose fl x = failwith "unimplemented"
;;


(*
 * doublesquare l : int list list -> int list
 *      Returns a list containing the squaresums of every
 *      list in l
 *)

let doublesquare l = failwith "unimplemented"
;;


(*
 * positives l : int list -> bool list
 *      Returns a list containing true for all positive
 *      elements, and false for negatives (0 is positive
 *      in this case)
 *)

let positives l = failwith "unimplemented"
;;

(* findmax l : int list -> int
 *      Returns an int that is the largest element in the
 *      list. The list will be only positive integers.  
 *      Return -1 if the list is empty. (Hint: try to use fold)
 *)

let findmax l = failwith "unimplemented"
;;
