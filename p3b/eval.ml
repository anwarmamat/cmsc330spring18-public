open Types
open Utils

exception TypeError of string
exception DeclareError of string
exception DivByZeroError

let rec eval_expr env e = failwith "unimplemented"

let rec eval_stmt env s = failwith "unimplemented"
