
% Grammar:
#pragma -comment
define program
        [repeat include_statement]
	[NL]
	[c_function]
end define


define c_function
	[comment_statement] [NL]
	[function_head] [NL]
	{ [NL][IN]
	  [repeat function_body]
	}
end define

define include_statement
	'#[SPOFF] [id] '< [id] '. [id] '>[SPON][NL]
end define

comments
	/* */
	//
end comments


define function_head
	[return_type] [function_name]()
end define

define function_name
	[id]
end define

define function_body
	[repeat variable_declaration] [NL]
	| [adding]; [NL]
	| [repeat scan_statement] [NL]
	| [repeat if_statement] [NL]
	| [repeat assignment_statement] [NL]
	| [repeat print_statement] [NL]
	| [repeat switch_statement] [NL]
	| [repeat for_statement] [NL]
	| [repeat while_statement] [NL]
	| [repeat do_statement] [NL]
	| [return_statement] [NL]
	| [comment_statement]
end define

define comment_statement
	[repeat comment_nl]
end define

define comment_nl
	[comment] [NL]
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

define assignment_statement
	[id] = [number]; [NL]
	| [id] = [charlit]; [NL]
	| [id] = [id] + [number]; [NL]
	| [id] = [id] - [number]; [NL]
	| [id] = [id] * [number]; [NL]
end define

define scan_statement
	scanf([stringlit],[SPOFF][id]);[SPON] [NL]
end define

tokens
	id | "[&]\i*"
end tokens

define bool_expr
	'>
	| '<
	| '!
	| =[SPOFF]=[SPON]
	| <[SPOFF]=[SPON]
end define

compounds
	'&&
	'||
end compounds

define expression
	[id_num] [bool_expr] [id_num]
	| [bool_expr] [SPOFF] ( [SPON] [id_num] [bool_expr] [id_num] )
end define

define inner_statement
	[repeat function_body][EX]
end define
 
define if_statement
	[if_inner][EX]
end define


define if_inner
	if ( [conditions] ) [NL][IN]
		[repeat function_body][opt break_statement] [NL][EX]
	[opt else_statement]
	| if ( [conditions] ) [NL]
	  	[bracket_begin] [IN]
      	[repeat function_body] [opt break_statement]
	  	[EX][bracket_end]
	  	[opt else_statement]
end define

define else_statement
	[else_inner][EX]
end define

define else_inner
	else [NL]
	[bracket_begin][IN]
    [repeat function_body][EX]
	[bracket_end]
	|else [NL][IN]
	 [repeat function_body][NL][EX]
end define

define bracket_begin
	{ [NL]
end define

define bracket_end
	} [NL]
end define

define id_num
   	[id]
    | [number]
	| '-[number]
end define

define conditions
	[expression]
	| [expression] [and_or] [expression]
end define 

define and_or
	'&&
	| '||
end define

define switch_statement
	switch ( [id] ) [NL]
	[bracket_begin] [IN]
	[repeat case_statement] [EX]
	[IN] [default_statement] [EX]
	[bracket_end]
end define

define case_statement
	case [charlit] [SPOFF] : [SPON] [NL]
	[IN] [print_statement]
	break; [NL] [EX]
end define

define default_statement
	default [SPOFF] : [SPON] [NL]
	[IN] [print_statement] [EX]
end define

define for_statement
	[inner_for]
end define

define inner_for
	for ( [loop_assign]; [expression]; [adding]  ) [NL]
	[bracket_begin] [IN]
	[repeat function_body] [EX]
	[EX][bracket_end]
	|for ( [loop_assign]; [expression]; [adding]  ) [NL][IN]
	 [repeat function_body] [NL][EX]
end define

define loop_assign
	[id] = [number]
	| [id] = [id]
end define

define adding
	[id][SPOFF] ++ [SPON]
end define


define while_statement
	while ( [expression] ) [NL]
	[bracket_begin] [IN]
	[repeat function_body]
	[EX] [bracket_end]
end define

define do_statement
	do [NL]
	[bracket_begin] [IN]
	[repeat function_body] [EX]
	[bracket_end]
	while ( [expression] ); [NL]
end define

define break_statement
	break; [NL]
end define


% Rules:
function main
    match [program]
	P[program]
end function
