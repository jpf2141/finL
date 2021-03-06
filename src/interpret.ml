open Ast

let rec eval = function 
    Int(x) -> x
  | Binop(e1, op, e2) ->
      let v1 = eval e1 and v2 = eval e2 in
      let boolean i = if i then 1 else 0 in
      match op with
	Add -> v1 + v2
	| Sub -> v1 - v2
	| Mult -> v1 * v2
	| Div -> v1 / v2
	| Equal -> boolean (v1 = v2)
	| Less -> boolean (v1 < v2)
	| Leq -> boolean (v1 <= v2)
	| Greater -> boolean (v1 > v2)
	| Geq -> boolean (v1 >= v2)

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let expr = Parser.expression Scanner.token lexbuf in
  let result = eval expr in
  print_endline (string_of_int result)