#ifndef I_slulisting_GROG
#define I_slulisting_GROG

   /*
    * Grog Class Declaration File 
    * Dated: 08/05/93
    */

#include "grog.h"

   /*
    * Class: slulisting
    */

struct s_slulisting {
   /*
    * Data members
    */
   char style[2];
   char rank[2];
   char fpi[2];
   char govlev[3];
   char rectyp[2];
   char list[3];
   char wpdc[5];
   char reprint[5];
   char telno[11];
   char rspos[5];
   char nstel[51];
   char srvof[5];
   char srvno[13];
   char srvdt[30];
   char nmsur[256];
   char nmsub[256];
   char title[256];
   char lineage[256];
   char honor[256];
   char busdsc[256];
   char house[256];
   char bldno[256];
   char bldpre[256];
   char bldpost[256];
   char str[256];
   char strpre[256];
   char strtyp[256];
   char strpost[256];
   char fullcom[256];
   char state[256];
   char zip[11];
   char fft[256];
   char county[256];
   char effst[3];
   char ifn[2];
   char notyp[3];
   char status[2];
   char origin[2];
   char priority[2];
   char lstmod[30];
   char setmod[30];
   char senddt[30];
   double set_id;
   double mem_id;
   double child_id;
   double par_id;
   char modified[3];
   double processed;
   char op_id[21];
   double rank1_parent;
   double rank2_parent;
   double rank3_parent;
   double rank4_parent;
   double rank5_parent;
   double rank6_parent;
   double rank7_parent;
   double rank8_parent;
   char index_name[62];
   char index_str[31];
   char tcid[2];
   char class[4];
   char special[31];
   char cna[2];
   char nts[2];
   char abrcom[256];

   /*
    * Pointer to self, implicit in the design
    */
   struct s_slulisting *self;

   t_GrogReturnCode (*style_is_valid)();
   t_GrogReturnCode (*rank_is_valid)();
   t_GrogReturnCode (*fpi_is_valid)();
   t_GrogReturnCode (*govlev_is_valid)();
   t_GrogReturnCode (*rectyp_is_valid)();
   t_GrogReturnCode (*list_is_valid)();
   t_GrogReturnCode (*wpdc_is_valid)();
   t_GrogReturnCode (*reprint_is_valid)();
   t_GrogReturnCode (*telno_is_valid)();
   t_GrogReturnCode (*rspos_is_valid)();
   t_GrogReturnCode (*nstel_is_valid)();
   t_GrogReturnCode (*srvof_is_valid)();
   t_GrogReturnCode (*srvno_is_valid)();
   t_GrogReturnCode (*srvdt_is_valid)();
   t_GrogReturnCode (*nmsur_is_valid)();
   t_GrogReturnCode (*nmsub_is_valid)();
   t_GrogReturnCode (*title_is_valid)();
   t_GrogReturnCode (*lineage_is_valid)();
   t_GrogReturnCode (*honor_is_valid)();
   t_GrogReturnCode (*busdsc_is_valid)();
   t_GrogReturnCode (*house_is_valid)();
   t_GrogReturnCode (*bldno_is_valid)();
   t_GrogReturnCode (*bldpre_is_valid)();
   t_GrogReturnCode (*bldpost_is_valid)();
   t_GrogReturnCode (*str_is_valid)();
   t_GrogReturnCode (*strpre_is_valid)();
   t_GrogReturnCode (*strtyp_is_valid)();
   t_GrogReturnCode (*strpost_is_valid)();
   t_GrogReturnCode (*fullcom_is_valid)();
   t_GrogReturnCode (*state_is_valid)();
   t_GrogReturnCode (*zip_is_valid)();
   t_GrogReturnCode (*fft_is_valid)();
   t_GrogReturnCode (*county_is_valid)();
   t_GrogReturnCode (*effst_is_valid)();
   t_GrogReturnCode (*ifn_is_valid)();
   t_GrogReturnCode (*notyp_is_valid)();
   t_GrogReturnCode (*status_is_valid)();
   t_GrogReturnCode (*origin_is_valid)();
   t_GrogReturnCode (*priority_is_valid)();
   t_GrogReturnCode (*lstmod_is_valid)();
   t_GrogReturnCode (*setmod_is_valid)();
   t_GrogReturnCode (*senddt_is_valid)();
   t_GrogReturnCode (*set_id_is_valid)();
   t_GrogReturnCode (*mem_id_is_valid)();
   t_GrogReturnCode (*child_id_is_valid)();
   t_GrogReturnCode (*par_id_is_valid)();
   t_GrogReturnCode (*modified_is_valid)();
   t_GrogReturnCode (*processed_is_valid)();
   t_GrogReturnCode (*op_id_is_valid)();
   t_GrogReturnCode (*rank1_parent_is_valid)();
   t_GrogReturnCode (*rank2_parent_is_valid)();
   t_GrogReturnCode (*rank3_parent_is_valid)();
   t_GrogReturnCode (*rank4_parent_is_valid)();
   t_GrogReturnCode (*rank5_parent_is_valid)();
   t_GrogReturnCode (*rank6_parent_is_valid)();
   t_GrogReturnCode (*rank7_parent_is_valid)();
   t_GrogReturnCode (*rank8_parent_is_valid)();
   t_GrogReturnCode (*index_name_is_valid)();
   t_GrogReturnCode (*index_str_is_valid)();
   t_GrogReturnCode (*tcid_is_valid)();
   t_GrogReturnCode (*class_is_valid)();
   t_GrogReturnCode (*special_is_valid)();
   t_GrogReturnCode (*cna_is_valid)();
   t_GrogReturnCode (*nts_is_valid)();
   t_GrogReturnCode (*abrcom_is_valid)();



   /*
    * Constructor and Destructor Methods, implicit in the design
    */

   struct s_slulisting *(*construct)();
   void (*destruct)();
   t_GrogReturnCode (*insert)();
   t_GrogReturnCode (*delete)();
   t_GrogReturnCode (*is_valid)();
   t_GrogReturnCode (*print)();

   /*
    * Method members
    */

   t_GrogReturnCode (*set_from_listing)();
};
typedef struct s_slulisting t_slulisting;

extern t_slulisting slulisting;

#endif
