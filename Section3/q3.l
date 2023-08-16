%{
  #include<stdio.h>
  #include<string.h>
  int yylval=-1;
  int lines = 1;

  //Token Types
  #define IF 1
  #define ELSE 2
  #define THEN 3
  #define RELOP 4
  #define ARITHMETIC 5
  #define ASSIGNMENT 6
  #define ID 7
  #define INTEGER 8
  #define FLOAT 9
  #define INT_NUM 10
  #define FLOAT_NUM 11
  #define FUNC 12
  #define LOOP 13
  #define SEPARATOR 14
  #define CHAR 15
  #define IO_CONSTRUCT 16
  #define MAIN 17

  //Relational operator types
  #define LT 21
  #define LE 22
  #define EQ 23
  #define NE 24
  #define GT 25
  #define GE 26

  //Arithmetic operator types

  #define INCREMENT 51
  #define DECREMENT 52

  //IO operator types
  #define INPUT_CONSTRUCT 161
  #define OUTPUT_CONSTRUCT 162

%}

delim [ \t]
letter [A-Za-z]
digit [0-9]
id ({letter})({letter}|{digit})*
ws {delim}+
int_num {digit}+
float_num ({digit}+)(\.{digit}+)?(E[+-]?({digit})+)?
operator (\+|\*|\/|\-)
separator [;,(){}]
assignment =
input_construct input\({id}\)
output_construct display\({id}\)

%%
{ws}*   
{separator} {yylval = (int)yytext[0]; return (SEPARATOR);}
main\(\)   {return (MAIN);}
if   { return(IF);}
then  { return(THEN);}
else  { return(ELSE);}
for   { yylval=LOOP; return(LOOP);}
while { yylval=LOOP; return(LOOP);}
{input_construct} { yylval=INPUT_CONSTRUCT; return (IO_CONSTRUCT);}
{output_construct} { yylval=OUTPUT_CONSTRUCT; return (IO_CONSTRUCT);}
"int"|"INT"   {return (INTEGER);}
"float"|"FLOAT"   { yylval= FLOAT; return (FLOAT);}
"char"|"CHAR"   { yylval=CHAR; return (CHAR);}
"++"  {yylval= INCREMENT; return (ARITHMETIC);}
"--"  {yylval= DECREMENT; return (ARITHMETIC);}
{int_num}  { yylval=INT_NUM; return (INT_NUM);}
{float_num} { yylval=FLOAT_NUM; return (FLOAT_NUM);}
{id} {return (ID);}
{assignment}  {
              int ans=(int) yytext[0]; 
              if(strlen(yytext)>1){
                ans+=(int) yytext[1];
              }
              yylval=ans;
              return (ASSIGNMENT);
              }
{operator}  {yylval = (int)yytext[0]; return(ARITHMETIC);}
"<"       {yylval= LT; return(RELOP);}
"<="       {yylval= LE; return(RELOP);}
"=="       {yylval= EQ; return(RELOP);}
"!="       {yylval= NE; return(RELOP);}
">"       {yylval= GT; return(RELOP);}
">="       {yylval= GE; return(RELOP);}
"\n"       {lines++;}
.           {printf("Error\n");}
%%


int yywrap() { return 1;}


int main() {
  int token;
  yyin = fopen ("input.txt","r"); 
  while((token=yylex())!=0){
    printf("Token: %d\tText:%s\t\tValue:%d\n",token,yytext,yylval);}
  return 0;
}
