#ifndef I_grogclass_GROG
#define I_grogclass_GROG

   /*
    * Grog Class Declaration File 
    * Dated: 07/13/93
    */

#include "grog.h"

   /*
    * Class: grogclass
    */

struct s_grogclass {
   /*
    * Data members
    */
   char name[30 + 1];

   tGrogReturnCode (*name_is_valid)();

   /*
    * Pointer to self, implicit in the design
    */
   struct s_grogclass *self;



   /*
    * Constructor and Destructor Methods, implicit in the design
    */

   struct s_grogclass *(*construct)();
   void (*destruct)();
   t_GrogReturnCode (*insert)();
   t_GrogReturnCode (*delete)();

   /*
    * Method members
    */

   /\* <NO METHOD MEMBERS DECLARED FOR grogclass> \*/
};
typedef struct s_grogclass t_grogclass;

extern t_grogclass grogclass;

#endif
