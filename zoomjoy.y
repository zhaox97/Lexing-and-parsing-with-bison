%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int yylex();
	void yyerror(const char* s);
	void check_negative(int x, int y, int a, int b);
	void errorcheck(int x, int y, int z);
%}

%error-verbose

%union{int i;float f;}

%start program

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT


%%
program: statement_list END
;
statement_list:	statement
	|	statement_list statement
;
statement:	expression END_STATEMENT
;
expression:	point
	|	line
	|	circle
	|	rectangle
	|	set_color
;
point:  POINT INT INT          { check_negative($2,$3,$2,$3);point($2,$3);}
;
line:   LINE INT INT INT INT    { check_negative($2,$3,$4,$5);line($2,$3,$4,$5);}
;
circle: CIRCLE INT INT INT      { check_negative($2,$3,$4,$2);circle($2,$3,$4);}
;
rectangle: RECTANGLE INT INT INT INT    {check_negative($2,$3,$4,$5); rectangle($2,$3,$4,$5);}
;
set_color: SET_COLOR INT INT INT        { check_negative($2,$3,$4,$2);errorcheck($2,$3,$4);set_color($2,$3,$4)}
;
%%
int main(int argc, char** argv){
	setup();
	yyparse();
	finish();
}
void yyerror(const char* s){
	fprintf(stderr,"Error: %s\n",s);
}
void check_negative(int x, int y, int a, int b){
	if(x<0||y<0||a<0||b<0){
		yyerror("Input must be possitive!\n");
	}
}
void errorcheck(int x, int y, int z){
	if(x>255||y>255||z>255){
		yyerror("Color Range is Invalid!\n");
	}
}
