%{
#include <stdio.h>
%}

%option noyywrap

%x COMMENT_INLINE

%%
\/\/                    BEGIN COMMENT_INLINE;
<COMMENT_INLINE>[^\n]*  /* skip comment text */
<COMMENT_INLINE>\n      { BEGIN(INITIAL); printf("COMMENT\n"); }

f                       printf("floatdcl ");
i                       printf("intdcl ");
p                       printf("print ");
[a-eg-hj-noq-z]         printf("id ");
[0-9]+\.[0-9]+          printf("fnum ");
[0-9]+                  printf("inum ");
=                       printf("assign ");
\+                      printf("plus ");
[ \t\n]+                /* ignore whitespace */
.                       /* catch-all: ignore unknowns */
%%

int main(void) {
    yylex();
    return 0;
}
