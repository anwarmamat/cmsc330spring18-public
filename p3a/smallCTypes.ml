exception InvalidInputException of string

type token = 
  | Tok_While
  | Tok_Int_Type
  | Tok_Bool_Type
  | Tok_Sub
  | Tok_Semi
  | Tok_RParen
  | Tok_RBrace
  | Tok_Print
  | Tok_Pow
  | Tok_Add
  | Tok_Or
  | Tok_NotEqual
  | Tok_Not
  | Tok_Mult
  | Tok_Main
  | Tok_LessEqual
  | Tok_Less
  | Tok_LParen
  | Tok_LBrace
  | Tok_Int of int
  | Tok_If
  | Tok_ID of string
  | Tok_GreaterEqual
  | Tok_Greater
  | Tok_Equal
  | Tok_Else
  | Tok_Div
  | Tok_Bool of bool
  | Tok_Assign
  | Tok_And
  | EOF

type data_type =
  | Int_Type
  | Bool_Type

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

type stmt =
  | NoOp                        (* For parser termination *)
  | Seq of stmt * stmt          (* True sequencing instead of lists *)
  | Declare of data_type * string  (* Here the expr must be an id but students don't know polymorphic variants *)
  | Assign of string * expr       (* Again, LHS must be an ID *)
  | If of expr * stmt * stmt    (* If guard is an expr, body of each block is a stmt *)
  | While of expr * stmt        (* Guard is an expr, body is a stmt *)
  | Print of expr               (* Print the result of an expression *)

type value =
  | Int_Val of int
  | Bool_Val of bool

type environment = (string * value) list
