%{	
	#include"zoomjoy.tab.h"
	#include<stdlib.h>
	#include"zoomjoystrong.h"
%}

%%
<<EOF>>			{return END;}
;			{return END_STATEMENT;}
point			{return POINT;}
line			{return LINE;}
circle			{return CIRCLE;}
rectangle		{return RECTANGLE;}
set_color		{return SET_COLOR;}
[0-9]+			{yylval.i = atoi(yytext); return INT;}
[+-]?([0-9]*[.])?[0-9]+ 	{yylval.f = atof(yytext);return FLOAT;}
[ \n\t]+		;
.			printf("Unknown character: %s\n", yytext); /*match aanything not list above*/
%%
int yywrap(void) {
    return 1;
}
