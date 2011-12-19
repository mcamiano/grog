   /*
    * Grog Class Definition File 
    * Dated: 07/07/93
    */

   /*
    * Class: listing
    */

/* Ignored base-table 'smsr.listing' for #include */
#include "listing.h"
#include <stdlib.h>
#include <stdio.h>

   /*
    * INCLUDE OTHER HEADER FILES HERE
    */

   /*
    * Destructor for objects of type t_listing
    */

void t_listing_destruct( object )
t_listing *object;
{
   free( object->self );
   return;
}

   /*
    * Constructor for objects of type t_listing
    */

t_listing *t_listing_construct()
{
   t_listing *buf=(t_listing*)malloc(sizeof(t_listing));
   buf->self = buf;

   { extern t_listing *t_listing_construct(); 
     buf->construct=t_listing_construct; }

   { extern void listing_destruct(); 
     buf->destruct=t_listing_destruct; }

   { extern t_GrogReturnCode t_listing_set_nmsur();
     buf->set_nmsur = t_listing_set_nmsur; }

   { extern t_GrogReturnCode t_listing_set_nmsub();
     buf->set_nmsub = t_listing_set_nmsub; }

   { extern t_GrogReturnCode t_listing_print_nmsur();
     buf->print_nmsur = t_listing_print_nmsur; }

   { extern t_GrogReturnCode t_listing_print_nmsub();
     buf->print_nmsub = t_listing_print_nmsub; }

   { extern t_GrogReturnCode t_listing_locate();
     buf->locate = t_listing_locate; }

   { extern t_GrogReturnCode t_listing_insert();
     buf->insert = t_listing_insert; }

   { extern t_GrogReturnCode t_listing_delete();
     buf->delete = t_listing_delete; }

   { extern t_GrogReturnCode t_listing_update();
     buf->update = t_listing_update; }

   return(buf->self);
}


   /*
    * Method: set_nmsur() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_set_nmsur( self, value )
t_listing *self;
char value[];
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   strcpy( self->nmsur, value );
   return( returnCode );
}

   /*
    * Method: set_nmsub() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_set_nmsub( self, value )
t_listing *self;
char value[];
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   strcpy( self->nmsub, value );
   return( returnCode );
}

   /*
    * Method: print_nmsur() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_print_nmsur( self )
t_listing *self;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   PRINTSTRING( self->nmsur );

   return( returnCode );
}

   /*
    * Method: print_nmsub() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_print_nmsub( self )
t_listing *self;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   PRINTSTRING( self->nmsub );

   return( returnCode );
}

   /*
    * Method: locate() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_locate( self )
t_listing *self;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   return( returnCode );
}

   /*
    * Method: insert() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_insert( self )
t_listing *self;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   return( returnCode );
}

   /*
    * Method: delete() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_delete( self )
t_listing *self;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   return( returnCode );
}

   /*
    * Method: update() returning t_GrogReturnCode
    */

static t_GrogReturnCode t_listing_update( self )
t_listing *self;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   return( returnCode );
}
   /*
    * Meta-object used for construction (and optionally for destruction)
    */

t_listing listing = {
   
/* style */ "",
   /* rank */ "",
   /* fpi */ "",
   /* govlev */ "",
   /* rectyp */ "",
   /* list */ "",
   /* wpdc */ "",
   /* reprint */ "",
   /* telno */ "",
   /* rspos */ "",
   /* nstel */ "",
   /* srvof */ "",
   /* srvno */ "",
   /* srvdt */ "",
   /* nmsur */ "",
   /* nmsub */ "",
   /* title */ "",
   /* lineage */ "",
   /* honor */ "",
   /* busdsc */ "",
   /* house */ "",
   /* bldno */ "",
   /* bldpre */ "",
   /* bldpost */ "",
   /* str */ "",
   /* strpre */ "",
   /* strtyp */ "",
   /* strpost */ "",
   /* fullcom */ "",
   /* state */ "",
   /* zip */ "",
   /* fft */ "",
   /* county */ "",
   /* effst */ "",
   /* ifn */ "",
   /* notyp */ "",
   /* status */ "",
   /* origin */ "",
   /* priority */ "",
   /* lstmod */ "",
   /* setmod */ "",
   /* senddt */ "",
   /* set_id */ (double) 0.0,
   /* mem_id */ (double) 0.0,
   /* child_id */ (double) 0.0,
   /* par_id */ (double) 0.0,
   /* modified */ "",
   /* processed */ (double) 0.0,
   /* op_id */ "",
   /* rank1_parent */ (double) 0.0,
   /* rank2_parent */ (double) 0.0,
   /* rank3_parent */ (double) 0.0,
   /* rank4_parent */ (double) 0.0,
   /* rank5_parent */ (double) 0.0,
   /* rank6_parent */ (double) 0.0,
   /* rank7_parent */ (double) 0.0,
   /* rank8_parent */ (double) 0.0,
   /* index_name */ "",
   /* index_str */ "",
   /* tcid */ "",
   /* class */ "",
   /* special */ "",
   /* cna */ "",
   /* nts */ "",
   /* abrcom */ "",
   
   /* self */ (t_listing *) &listing ,
   /* construct */ t_listing_construct,
   /* destruct */ t_listing_destruct ,
   /* set_nmsur */ t_listing_set_nmsur ,
   /* set_nmsub */ t_listing_set_nmsub ,
   /* print_nmsur */ t_listing_print_nmsur ,
   /* print_nmsub */ t_listing_print_nmsub ,
   /* locate */ t_listing_locate ,
   /* insert */ t_listing_insert ,
   /* delete */ t_listing_delete ,
   /* update */ t_listing_update

};


