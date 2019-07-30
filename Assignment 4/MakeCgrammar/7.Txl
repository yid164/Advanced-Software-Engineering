% Yinsheng Dong
% Grammar:
define program
	[c_function]
end define

define c_function
	[function_head] [NL]
	{ [NL][IN]
	  [function_body]
	}
end define

define function_head
	[return_type] [function_name]()
end define

define function_name
	[id]
end define

define function_body
	[repeat variable_declaration] [return_statement]
	| [print_statement] [return_statement]
	| [repeat variable_declaration] [repeat assign_statement] [return_statement]
end define

define return_type
	int
end define

define variable_declaration
	[id][SP][SPOFF][list id];[SPON] [NL]
	| [id] [id] [id] = [number]; [NL]
	| [id] [id] [id]; [NL]
end define

define print_statement
	printf([stringlit]); [NL]
	| printf([stringlit],[SPOFF][id]); [SPON][NL]
end define

define return_statement
	return [return_value]; [NL][EX]
end define

define return_value
	[number]
end define

define assign_statement
	[id] = [number]; [NL]
	|[id] = [charlit]; [NL]
	|[id] = [id] + [number]; [NL]
	|[id] = [id] - [number]; [NL]
end define

% Rules:
function main
    match [program]
	P[program]
end function