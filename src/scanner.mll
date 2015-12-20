{ open Parser }

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']

rule token = parse
	[' ' '\t' '\r' '\n']     { token lexbuf }
	| '#'                    { comment lexbuf }
	| '('                    { LPAREN }
	| ')'                    { RPAREN }
	| '{'                    { LBRACE }
	| '}'                    { RBRACE }
	(*| ':'                    { COLON }*)
	| ';'                    { SEMI }
	| ','                    { COMMA }
	| '+'                    { PLUS }
	| '-'                    { MINUS }
	| '*'                    { TIMES }
	| '/'                    { DIVIDE }
	| '%'                    { MOD }
	| "**"                   { POWER }
	| '<'                    { LT }
	| "<="                   { LEQ }
	| '>'                    { GT }
	| ">="                   { GEQ }
	| '='                    { EQ }
	| "<<"                   { ASSIGN }
	| "+<<"                  { AASSIGN }
	| "-<<"                  { SASSIGN }
	| "*<<"                  { MASSIGN }
	| "/<<"                  { DASSIGN }
	| "and"                  { AND }
	| "or"                   { OR }
	| "not"                  { NOT }
	| '?'                    { IF }
	(*| "??"                   { ELSEIF }
	| '!'                    { ELSE }*)
	| "while"                { WHILE }
	(*| "when"                 { WHEN }
	| "break"                { BREAK }*)
	| "int"                  { INTD }
	| "float"                { FLOATD }
	(*| "percent"              { PERCENT }
	| "null"                 { NULL }
	| "array"                { ARRAY }*)
	| "string"               { STRINGD }
	(*| "currency"             { CURR }*)
	| "stock"                { STOCK }
	(*| "order"                { ORDER }
	| "portfolio"            { PF }*)
	| "function"             { FUNC }
	| "return"               { RETURN }
	| "void"                 { VOID }
	| '@'letter+ as t		 { TICK(t) }
	| letter+(letter|digit|'_')* as var   { VAR(var) }
	| digit+ as i            { INT(int_of_string i) }
	| digit*'.'digit+ as flt { FLOAT(float_of_string flt) }
	| '"'('\\'_|[^'"'])*'"' as str   { STRING(str) }
	| eof                  	 { EOF }

and comment = parse
	'\n' { token lexbuf }
	| eof { EOF }
	| _  { comment lexbuf }