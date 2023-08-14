%{
#include<stdio.h>
#include<string.h>
#define ERROR -1
%}
%%
(1*01*01*)* | (0*10*10*)*0*10*(0*10*10*)*    {return 1;}
.*     {return ERROR;}
%%
int yywrap(void){
return 1;
}
int main(void)
{
yyin=fopen("test_1_2.txt","r+");
if(yylex()==1)
  printf("Even number of zeroes or odd number of ones found\n");
else
  printf("Rejected\n");
}
