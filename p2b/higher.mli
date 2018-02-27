val is_over_x: 'a -> 'a list -> bool list
val count_over_x: 'a -> 'a list -> int
val mean : float list -> float
val pred_succ : int list -> int list
val bind : ('a -> 'b list) -> 'a list -> 'b list
val ap : ('a -> 'b) list -> 'a list -> 'b list
