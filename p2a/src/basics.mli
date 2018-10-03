val divides: int -> int -> bool
val gcd: int -> int -> int
val ack: int -> int -> int 

val second_element : int list -> int
val max_first_three : int list -> int

val partial_sum : int -> int list -> int
val partial_sums : int list -> int list -> int list
val zip : 'a list -> 'b list -> ('a * 'b) list
val index : 'a -> 'a list -> int

val elem : 'a -> 'a list -> bool
val insert : 'a -> 'a list -> 'a list
val subset : 'a list -> 'a list -> bool
val eq : 'a list -> 'a list -> bool
val remove : 'a -> 'a list -> 'a list
val union : 'a list -> 'a list -> 'a list
val intersection : 'a list -> 'a list -> 'a list
val product : 'a list -> 'b list -> ('a * 'b) list
