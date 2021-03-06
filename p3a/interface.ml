open Utils;;

let print_usage () =
  print_string "\nThis file functions as a driver for interfacing with the SmallC lexer and parser.\n\n";
  print_string "Usage:\n";
  print_string "\t./interface <mode> <filename>: Run your parser and lexer on standard input, or a file if one is provided.\n";
  print_string "Modes:\n";
  print_string "\tlex: Run in lex mode to show the tokens output by your lexer\n";
  print_string "\tparse_expr: Parse an expression using parse_expr\n";
  print_string "\tparse_stmt: Parse a statement using parse_stmt\n";
  print_string "\tparse: Parse a full program, including the function header, using parse_main\n\n";
;;

if Array.length Sys.argv < 2 then begin print_usage (); exit 1 end;;


let ch = if Array.length Sys.argv > 2 then open_in Sys.argv.(2) else stdin;;
let toks = tokenize_from_channel ch;;

match Sys.argv.(1) with
| "lex" ->
  print_string @@ string_of_list ~newline:true string_of_token toks
| "parse_expr" ->
  let (remaining, e) = Parser.parse_expr toks in
  print_string @@ string_of_expr e;
  print_string ("\nRemaining tokens: " ^ (string_of_list ~newline:true string_of_token remaining))
| "parse_stmt" ->
  let (remaining, e) = Parser.parse_stmt toks in
  print_string @@ string_of_stmt e;
  print_string ("\nRemaining tokens: " ^ (string_of_list ~newline:true string_of_token remaining))
| "parse" ->
  print_string @@ string_of_stmt @@ Parser.parse_main toks;
  print_newline ()
| x -> print_usage (); failwith ("Unknown mode '" ^ x ^ "'")
;;

(* This is intentionally physical equality *)
if ch != stdin then close_in ch;;
