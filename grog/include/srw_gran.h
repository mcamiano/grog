#ifndef I_srw_granted_GROG
#define I_srw_granted_GROG

   /*
    * Grog Class Declaration File 
    * Dated: 07/18/93
    */

#include "grog.h"

   /*
    * Class: srw_granted
    */

struct s_srw_granted {
   /*
    * Data members
    */
   double appid;
   char grantee[240 + 1];

   tGrogReturnCode (*appid_is_valid)();
   tGrogReturnCode (*grantee_is_valid)();

   /*
    * Pointer to self, implicit in the design
    */
   struct s_srw_granted *self;



   /*
    * Constructor and Destructor Methods, implicit in the design
    */

   struct s_srw_granted *(*construct)();
   void (*destruct)();
   t_GrogReturnCode (*insert)();
   t_GrogReturnCode (*delete)();

   /*
    * Method members
    */

   /\* <NO METHOD MEMBERS DECLARED FOR srw_granted> \*/
};
typedef struct s_srw_granted t_srw_granted;

extern t_srw_granted srw_granted;

#endif
