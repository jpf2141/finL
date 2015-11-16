open Ast

let string_of_op = function
	Add -> "+"
	| Sub -> "-"
	| Mult -> "*"
	| Div -> "/"
	| Equal -> "=="
	| Less -> "<"
	| Leq -> "<="
	| Greater -> ">"
	| Geq -> ">="

let rec compile_expression = function
  String(str) -> str
  | Binop(expr1, op, expr2) -> compile_expression expr1 ^ string_of_op op ^ compile_expression expr2
  | Assign(var, expr) -> var ^ "=" ^ compile_expression expr
  | Var(str) -> str
  | Call(name, expr) -> name ^ "(" ^ compile_expression expr ^ ")"
  

let compile_statement = function
  Expr(expr) -> compile_expression expr ^ ";"
  (*DECLARATIONS*)

let compile_fdecl (func: Ast.func_decl) =
  "public static void " ^
  func.name ^
  (* ADD ARGUMENTS!!!!!! / remove hardcoding *)
  "(String[] args) {\n" ^
  String.concat "\n" (List.map compile_statement func.body) ^
  "}"

let compile (prog: Ast.program) =
  "public class finl{\n" ^
  (*String.concat "\n" (List.map compile_vdecl prog.vdecls) ^*)
  String.concat "\n" (List.map compile_fdecl prog.fdecls) ^
  "\n}"