/*
 *  The scanner definition for COOL.
 */

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */

%}

/*
 * Define names for regular expressions here.
 */

LINECOMMENT     --.*
SIMPLESTRING    \".*\"
DARROW          =>
LARROW          <-
CLASS           [cC][lL][aA][sS][sS]
ELSE            [eE][lL][sS][eE]                        
FI              [fF][iI]                      
IF              [iI][fF]                      
IN              [iI][nN]                      
INHERITS        [iI][nN][hH][eE][rR][iI][tT][sS]
LET             [lL][eE][tT]                  
LOOP            [lL][oO][oO][pP]              
POOL            [pP][oO][oO][lL]              
THEN            [tT][hH][eE][nN]              
WHILE           [wW][hH][iI][lL][eE]          
CASE            [cC][aA][sS][eE]              
ESAC            [eE][sS][aA][cC]              
NEW             [nN][eE][wW]                  
OF              [oO][fF]                      
NOT             [nN][oO][tT]
TRUE            t[rR][uU][eE]
FALSE           f[aA][lL][sS][eE]
ISVOID          [iI][sS][vV][oO][iI][dD]           
DIGIT      [0-9]
LETTER     [a-zA-Z]
WS         [ \t\r]+
LE          <=

%%

 /*
  *  Nested comments
  */

LINECOMMENT { /* no hace nada, los comentarios no se tokenizan */ }



 /*
  *  The multiple-character operators.
  */



{DARROW}		{ return (DARROW); }
{LARROW}    { return (ASSIGN); }
{LE}        { return (LE); }


 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */

{TRUE}      { cool_yylval.boolean = true; return BOOL_CONST; }
{FALSE}     { cool_yylval.boolean = false; return BOOL_CONST; }
{ISVOID}  { return ISVOID; }
{CLASS}    { return CLASS; }
{ELSE}      { return ELSE; }
{FI}      { return FI; }
{IF}      { return IF; }
{IN}      { return IN; }
{INHERITS}      { return INHERITS; }
{LET}     { return LET; }
{LOOP}      { return LOOP; }
{POOL}      { return POOL; }
{THEN}      { return THEN; }
{WHILE}     { return WHILE; }
{CASE}      { return CASE; }
{ESAC}      { return ESAC; }
{NEW}     { return NEW; }
{OF}      { retur6. Lex Source Definitions.

Remember the format of the Lex source:

{definitions}
%%
{rules}
%%
{user routines}

So far only the rules have been described. The user needs additional options, though, to define variables for use in his program and for use by Lex. These can go either in the definitions section or in the rules section.

Remember that Lex is turning the rules into a program. Any source not intercepted by Lex is copied into the generated program. There are three classes of such things.

1) Any line which is not part of a Lex rule or action which begins with a blank or tab is copied into the Lex generated program. Such source input prior to the first %% delimiter will be external to any function in the code; if it appears immediately after the first %%, it appears in an appropriate place for declarations in the function written by Lex which contains the actions. This material must look like program fragments, and should precede the first Lex rule. As a side effect of the above, lines which begin with a blank or tab, and which contain a comment, are passed through to the generated program. This can be used to include comments in either the Lex source or the generated code. The comments should follow the host language convention.

2) Anything included between lines containing only %{ and %} is copied out as above. The delimiters are discarded. This format permits entering text like preprocessor statements that must begin in column 1, or copying lines that do not look like programs.

3) Anything after the third %% delimiter, regardless of formats, etc., is copied out after the Lex output.

Definitions intended for Lex are given before the first %% delimiter. Any line in this section not contained between %{ and %}, and beginning in column 1, is assumed to define Lex substitution strings. The format of such lines is

name translation

and it causes the string given as a translation to be associated with the name. The name and translation must be separated by at least one blank or tab, and the name must begin with a letter. The translation can then be called out by the {name} syntax in a rule. Using {D} for the digits and {E} for an exponent field, for example, might abbreviate rules to recognize numbers:

D [0-9]
E [DEde][-+]?{D}+
%%
{D}+ printf("integer");
{D}+"."{D}*({E})? |
{D}*"."{D}+({E})? |
{D}+{E}

Note the first two rules for real numbers; both require a decimal point and contain an optional exponent field, but the first requires at least one digit before the decimal point and the second requires at least one digit after the decimal point. To correctly handle the problem posed by a Fortran expression such as 35.EQ.I, which does not contain a real number, a context-sensitive rule such as

[0-9]+/"."EQ printf("integer");

could be used in addition to the normal rule for integers.

The definitions section may also contain other commands, including the selection of a host language, a character set table, a list of start conditions, or adjustments to the default size of arrays within Lex itself for larger source programs. These possibilities are discussed below under ``Summary of Source Format,'' section 12. n OF; }
{NOT}     { return NOT; }

"("         { return '('; }
")"         { return ')'; }
"{"         { return '{'; }
"}"         { return '}'; }
":"         { return ':'; }
";"         { return ';'; }
","         { return ','; }
"."         { return '.'; }
"@"         { return '@'; }
"~"         { return '~'; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"="         { return '='; }
"<"         { return '<'; }



{DIGIT}+ {
    cool_yylval.symbol = inttable.add_string(yytext);
    return INT_CONST;
}
[A-Z]({LETTER}|{DIGIT}|_)* {
    cool_yylval.symbol = idtable.add_string(yytext);
    return TYPEID;
}
[a-z]({LETTER}|{DIGIT}|_)* {
    cool_yylval.symbol = idtable.add_string(yytext);
    return OBJECTID;
}


 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */

%Start STRING

\" {BEGIN(STRING);}



%%
