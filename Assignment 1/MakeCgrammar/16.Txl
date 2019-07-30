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
	| [repeat variable_declaration] [repeat scan_statement] [repeat assign_statement] [repeat print_statement] [return_statement]
	| [repeat variable_declaration] [repeat scan_statement] [repeat if_statement] [repeat assign_statement] [repeat print_statement] [return_statement]
	| [repeat variable_declaration] [repeat print_statement] [repeat scan_statement] [switch_statement] [return_statement]
	| [repeat variable_declaration] [for_statement] [return_statement]
	| [repeat variable_declaration] [repeat scan_statement] [repeat assign_statement] [while_statement] [return_statement]
	| [repeat variable_declaration] [repeat scan_statement] [repeat assign_statement] [do_statement] [return_statement]
	
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
	|[id] = [id] * [number]; [NL]
end define

define scan_statement
	scanf([stringlit],[SPOFF][id]);[SPON] [NL]
end define

define opr
	'>
	| <[SPOFF]=[SPON]
	| '!
	| =[SPOFF]=[SPON]
end define

define else_statement
	else [NL]
	[opt bracket_begin] [IN]
	[repeat assign_statement] [repeat print_statement][EX]
	[opt bracket_end]
end define

define if_statement
	if ( [condition] ) [NL]
	[opt bracket_begin] [IN]
	[repeat assign_statement] [repeat print_statement][EX]
	[opt bracket_end]
	[opt else_statement]
end define

define id_num
	[id]
	|[number]
	| '-[number]
end define

define expression
	[id_num][opr][id_num]
	| [opr][SPOFF] ( [SPON] [id_num][opr][id_num] )
end define


define condition
	[expression]
	| [expression] [and_or] [expression]
end define

define bracket_begin
	{ [NL]
end define

define bracket_end
	} [NL]
end define

tokens
	id | "[&]\i*"
end tokens

compounds
	'&&
	'||
end compounds

define and_or
	'&&
	| '||
end define

define case_statement
	case[charlit] [SPOFF] : [SPON][NL]
	[IN] [print_statement]
	break; [NL][EX]
end define

define default_statement
	default [SPOFF] : [SPON] [NL]
	[IN] [print_statement][EX]
end define

define switch_statement
	switch([id]) [NL]
	[bracket_begin] [IN]
	[repeat case_statement] [EX]
	[IN] [default_statement] [EX]
	[bracket_end]
end define

define loop_statement
	[id] = [number]
	| [id] = [id]
end define

define adding
	[id][SPOFF] ++ [SPON]
end define

define loop_assign
	[id] = [number]
	| [id] = [id]
end define

define for_statement
	for ( [loop_assign]; [expression]; [adding] ) [NL]
	[opt bracket_begin] [IN]
	[repeat assign_statement] [repeat print_statement] [EX]
	[opt bracket_end]
end define

define while_statement
	while ( [expression] ) [NL]
	[opt bracket_begin] [IN]
	[adding]; [NL] [repeat print_statement] [EX]
	[opt bracket_end]
end define

define do_statement
	do [NL]
	[opt bracket_begin] [IN]
	[adding]; [NL] [repeat print_statement] [EX]
	[opt bracket_end]
	while ( [expression] ); [NL]
end define

% Rules:
function main
    match [program]
	P[program]
end function