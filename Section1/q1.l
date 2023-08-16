%{
#include<stdio.h>
#define VALID 0
#define ERROR -1
%}
valid (0|1)*1(0|1)*1(0|1)*1(0|1)*1(0|1)*  
%%
{valid} { printf("Contains 4 1's");return VALID;}
.* {return ERROR;} 
%%
int yywrap(void){
return 1;
}
int main(void)
{
  if(yylex())
  {
    printf("Invalid input\n"); 
  }
  return 0;
}
