%{
/*
 * expression parser example
 *
 * (c) 2012 Prof Dr Andreas Mueller
 */
#include <math.h>
%}
%union {
	double	value;
}
%token SIN COS TAN SQRT LOG EXP LOG10 LOG2
%token <value>NUMBER
%type <value>expr term factor
%%
calculator:
	|	exprline
	|	calculator exprline
	;
exprline:	expr '\n'		{ printf("result = %f\n", $1); }
	|	expr ';'		{ printf("result = %f;\n", $1); }
	;
expr:		term			{ $$ = $1; }
	|	expr '+' term		{ $$ = $1 + $3; }
	|	expr '-' term		{ $$ = $1 - $3; }
	;
term:		term '*' factor		{ $$ = $1 * $3; }
	|	term '/' factor		{ $$ = $1 / $3; }
	|	factor			{ $$ = $1; }
	;
factor:		'(' expr ')'		{ $$ = $2; }
	|	NUMBER			{ $$ = $1; }
	|	SIN '(' expr ')'	{ $$ = sin($3); }
	|	COS '(' expr ')'	{ $$ = cos($3); }
	|	TAN '(' expr ')'	{ $$ = tan($3); }
	|	SQRT '(' expr ')'	{ $$ = sqrt($3); }
	|	LOG '(' expr ')'	{ $$ = log($3); }
	|	LOG10 '(' expr ')'	{ $$ = log10($3); }
	|	LOG2 '(' expr ')'	{ $$ = log2($3); }
	|	EXP '(' expr ')'	{ $$ = exp($3); }
	;
%%

