%{
#include<stdio.h>
#include<string.h>
#define ERROR -1
int line_number=1;
%}

%%
([abc]*(aa)+[abc]*)|([abc]*(bb)+[abc]*) {return 1;}
\n   {line_number++;}
.*   {return ERROR;}
%%

int yywrap(){
return (1);
}

int main(int argc,char **argv)
{
 int token;
 yyin = fopen("test_1_3.txt","r+");
 while((token=yylex())!=0)
 {
 if(token==1 && yyleng==8)
  printf("Correct pattern found at line no:%d, %s\n",line_number,yytext);
 else 
  printf("Pattern not found\n");
 }
  return 0;
}
