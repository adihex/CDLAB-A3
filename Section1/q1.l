%{
#include<stdio.h>
%}
%%
(0|1)*1(0|1)*1(0|1)*1(0|1)*1(0|1)*  {
  printf("Contains 4 1's");
}
%%
int yywrap(void){
return 1;
}
int main(void)
{
  yylex();
  return 0;
}
