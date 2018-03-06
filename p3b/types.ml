type value =
  | Int_Val of int
  | Bool_Val of bool

type data_type =
  | Int_Type
  | Bool_Type

(* Expressions have values *)
type expr =
  | ID of string
  | Int of int
  | Bool of bool
  | Add of expr * expr
  | Sub of expr * expr
  | Mult of expr * expr
  | Div of expr * expr
  | Pow of  expr * expr
  | Greater of expr * expr
  | Less of expr * expr
  | GreaterEqual of expr * expr
  | LessEqual of expr * expr
  | Equal of expr * expr
  | NotEqual of expr * expr
  | Or of expr * expr
  | And of expr * expr
  | Not of expr

(* Statements don't have values *)
type stmt =
  | NoOp                        (* For parser termination *)
  | Seq of stmt * stmt          (* True sequencing instead of lists *)
  | Declare of data_type * string  (* Here the expr must be an id but students don't know polymorphic variants *)
  | Assign of string * expr       (* Again, LHS must be an ID *)
  | If of expr * stmt * stmt    (* If guard is an expr, body of each block is a stmt *)
  | While of expr * stmt        (* Guard is an expr, body is a stmt *)
  | Print of expr               (* Print the result of an expression *)

type environment = (string * value) list
