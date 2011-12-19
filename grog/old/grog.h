   /*
    * Grog Meta-declarations
    */

#ifndef I_grog_h
#define I_grog_h

enum e_GROG_RETURN_CODE { GROG_NULL=0, GROG_SUCCESS=1, GROG_FAILURE=-1, GROG_TRUE=1, GROG_FALSE=0 };  

typedef enum e_GROG_RETURN_CODE t_GrogReturnCode;

#define NEWLINE "\n"
#define SKIPLINE printf(NEWLINE)
#define SKIPLINES(x) printf("%*s", (x), NEWLINE)

#define SPACE " "
#define SKIPSPACE printf(SPACE)
#define SKIPSPACES(x) printf("%*s", (x), SPACE)
#define CENTER(text,linesize)   SKIPSPACES((linesize-strlen(text)/2)),printf("%.*s", linesize, text)

#define PRINTSTRING(x)   printf( (x) )
#define PRINTINTEGER(x)   printf( "%d", (x) )
#define PRINTFLOAT(x)   printf( "%f", (x) )

#endif
