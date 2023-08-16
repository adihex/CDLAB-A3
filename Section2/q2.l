%{
  #include<stdio.h>
  #include<string.h>
  #define ERROR -1
  int yylval=-1;

  //token types
  #define IF 1
  #define THEN 2
  #define ELSE 3
  #define ID 4
  #define NUM 5
  #define RELOP 6

  //Relop types
  #define LT 21
  #define LE 22
  #define EQ 23
  #define NE 24
  #define GT 25
  #define GE 26

%}


delim [ \t\n]
ws {delim}+
digit [0-9]
digits {digit}+
number {digits}(.{digits})?(E[+-]?{digits})?
letter [A-Za-z]
id ({letter}({letter}|{digit})*)
if "if"
then "then"
else "else"
relop (<|>|(<=)|(>=)|=|(<>))

%%

if {yylval =IF;return(IF);}
then {yylval=THEN;return(THEN);}
else {yylval=ELSE;return(ELSE);}
{ws}* 
{id} {yylval=ID;return(ID);}
{number} {yylval=NUM;return(NUM);}
{relop} {yylval=RELOP;return(RELOP);}
. {return ERROR;}
%%

int yywrap(void) {return 1;}

int main(void) {
  int token;
  yyin=fopen("input.txt","r");
  while((token=yylex())!=0){
    if(token!=-1)
    printf("Token: %d\tText:%s\t\tValue:%d\n",token,yytext,yylval);
    else printf("ERROR:Invalid token found:%s\n",yytext);
    yylval=-1;
  }
  return 0;
}
