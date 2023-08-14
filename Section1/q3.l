%{
#include<stdio.h>
#include<string.h>
#define ERROR -1
int line_number=1;
%}

%%
([abc]*(aa)+[abc]*)|([abc]*(bb)+[abc]*) {return 1;}
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
 if(yyleng==8)
  printf("Correct pattern found, %s, %d\n",yytext,token);
 if(token==ERROR) 
  printf("Wrong characters\n");
 }
  return 0;
}
