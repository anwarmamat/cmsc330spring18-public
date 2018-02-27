let rec map f l = match l with
    [] -> []
  | (h::t) -> (f h)::(map f t)
;;

let rec fold f a l = match l with
    [] -> a
  | (h::t) -> fold f (f a h) t
;;

let length x = fold (fun a y -> a+1) 0 x
;;

let rev x = fold (fun a y -> y::a) [] x
;;

let rec fold_right f l a =
  match l with
      [] -> a
    | h::t ->
      let a' = fold_right f t a in
      f h a'
;;
