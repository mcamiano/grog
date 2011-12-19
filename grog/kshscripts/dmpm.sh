#!/bin/ksh
dumpmmembers() {
   integer mcount=0
   CLASSNAME=$1

   echo "Exporting methods for ${CLASSNAME}" >&2

   baseclasses="'${CLASSNAME}'"
   bnames=""
   for i in 1
   do
      sqlplus -s $USERNAME <<EOT
set heading off
set feedback off
set pagesize 0
set long 500
set SHOW OFF
set linesize 500
set MAXDATA 32760
set ARRAYSIZE 2
select text
from user_views 
where lower(view_name) = lower('${CLASSNAME}') 
and rownum = 1
/
quit
/
EOT
   done | sed 's/.*[ \t]*from \(.*\)/!\1/g; /!/!d; ' |  cut -d"!" -f2 | \
      egrep -v -w  "^$|union *$|where" |  \
      while read cname
      do 
         #cname=`echo $cname`
         baseclasses=${baseclasses:+"$baseclasses,"}"'${cname}'"
         bnames=${bnames:+"$bnames "}"${cname}"
      done

   echo "   (Also deriving from baseclasses: $bnames...)" >&2


   if [ "$NO_METHOD_STUBS" = 0 ]
   then

   for bname in $bnames
   do
      sleep 1
      test_if_class=`sqlplus -s $USERNAME <<EOT
set heading off
set feedback off
set pagesize 0
set long 500
set SHOW OFF
set linesize 500
set MAXDATA 32760
set ARRAYSIZE 2
select count(*) from grogclass where lower(name) = lower('$bname')
/
quit
/
EOT
`
      if [ $test_if_class -eq 0 ]
      then
         echo "/* Ignored base-table '"$bname"' for #include */"
      else
         echo '#include "'$bname'.h"' 
      fi

   done >> $SourceFile

   fi

      if [ "$NO_METHOD_STUBS" = 0 ]
      then
   cat <<EOT >>$SourceFile
#include "${CLASSNAME}.h"
#include <stdlib.h>
#include <stdio.h>
EXEC SQL INCLUDE sqlca;   
	/*
	 * SQL/C Precompiler needs at least one global declaration block
	 *   to avoid a bug which causes 'undeclared reference' errors.
	 */
EXEC SQL BEGIN DECLARE SECTION;
	static char *grogclassname="${CLASSNAME}";
EXEC SQL END DECLARE SECTION;

#include "grog.h"

   /*
    * INCLUDE OTHER HEADER FILES HERE
    */

   /*
    * Validators for members of objects of type t_${CLASSNAME}
    */

GROG_MACRO_VALIDATION_DEFINITIONS

   /*
    * Validator for objects of type t_${CLASSNAME}
    */

t_GrogReturnCode t_${CLASSNAME}_is_valid( object )
t_${CLASSNAME} *object;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_SUCCESS;

   switch (1)
   {
	case 1:
   GROG_MACRO_VALIDATION_CALLS
   default:
      returnCode=GROG_SUCCESS;
   break;
   }

   return(returnCode);
}


   /*
    * Printer for objects of type t_${CLASSNAME}
    */

t_GrogReturnCode t_${CLASSNAME}_print( object )
t_${CLASSNAME} *object;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_SUCCESS;

   GROG_MACRO_PRINT_REFERENCES

   return(returnCode);
}

   /*
    * Insertor for objects of type t_${CLASSNAME}
    */

t_GrogReturnCode t_${CLASSNAME}_insert( object )
t_${CLASSNAME} *object;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   EXEC SQL BEGIN DECLARE SECTION;
   GROG_MACRO_HOST_DECLARATIONS
   EXEC SQL END DECLARE SECTION;

   returnCode = object->is_valid( object );

   if ( returnCode == GROG_SUCCESS )
   {
      GROG_MACRO_COPY_OBJECT_TO_HOST_VARIABLES

      EXEC SQL INSERT INTO ${CLASSNAME}
      (
         GROG_MACRO_HOST_NAMES
      )
      Values
      (
         GROG_MACRO_HOST_REFERENCES
      );

			returnCode =  (sqlca.sqlerrd[2] == 1) ? GROG_SUCCESS : GROG_FAILURE;
   }

   return(returnCode);
}

   /*
    * Deletor for objects of type t_${CLASSNAME}
    */

t_GrogReturnCode t_${CLASSNAME}_delete( object )
t_${CLASSNAME} *object;
{
   t_GrogReturnCode returnCode=(t_GrogReturnCode)GROG_NULL;

   EXEC SQL BEGIN DECLARE SECTION;
   GROG_MACRO_HOST_DECLARATIONS
   EXEC SQL END DECLARE SECTION;

   GROG_MACRO_COPY_OBJECT_TO_HOST_VARIABLES

   EXEC SQL DELETE FROM ${CLASSNAME}
   WHERE(
      GROG_MACRO_DELETE_CLAUSE
   );

	returnCode =  (sqlca.sqlerrd[2] == 1) ? GROG_SUCCESS : GROG_FAILURE;

   return(returnCode);
}

   /*
    * Destructor for objects of type t_${CLASSNAME}
    */

void t_${CLASSNAME}_destruct( object )
t_${CLASSNAME} *object;
{
   free( object->self );
   return;
}

   /*
    * Constructor for objects of type t_${CLASSNAME}
    */

t_${CLASSNAME} *t_${CLASSNAME}_construct()
{
   t_${CLASSNAME} *buf=(t_${CLASSNAME}*)malloc(sizeof(t_${CLASSNAME}));
   buf->self = buf;

   { extern t_${CLASSNAME} *t_${CLASSNAME}_construct(); 
     buf->construct=t_${CLASSNAME}_construct; }

   { extern void ${CLASSNAME}_destruct(); 
     buf->destruct=t_${CLASSNAME}_destruct; }

   { extern void ${CLASSNAME}_insert(); 
     buf->insert=t_${CLASSNAME}_insert; }

   { extern void ${CLASSNAME}_delete(); 
     buf->delete=t_${CLASSNAME}_delete; }

   { extern void ${CLASSNAME}_is_valid(); 
     buf->is_valid=t_${CLASSNAME}_is_valid; }

   { extern void ${CLASSNAME}_print(); 
     buf->print=t_${CLASSNAME}_print; }

	 GROG_MACRO_VALIDATION_CONSTRUCTS

EOT

   fi


   cat >> $HeaderFile <<EOT

   /*
    * Constructor and Destructor Methods, implicit in the design
    */

   struct s_${CLASSNAME} *(*construct)();
   void (*destruct)();
   t_GrogReturnCode (*insert)();
   t_GrogReturnCode (*delete)();
   t_GrogReturnCode (*is_valid)();
   t_GrogReturnCode (*print)();

   /*
    * Method members
    */

EOT

   echo "${MetaObjectInit:+$MetaObjectInit,}" >>$META_INIT_FILE
	 echo "\nGROG_MACRO_META_INIT\n">>$META_INIT_FILE
	 echo "   /* construct */ t_${CLASSNAME}_construct,/* destruct */ t_${CLASSNAME}_destruct,/* insert */ t_${CLASSNAME}_insert,/* delete */ t_${CLASSNAME}_delete, /* is_valid */ t_${CLASSNAME}_is_valid, /* print */ t_${CLASSNAME}_print\c" >> $META_INIT_FILE


   if [ ! -z "$baseclasses" ]
   then
      method_name=""
      echo "   \c" >&2
   for i in 1
   do

      sqlplus -s $USERNAME <<EOT
set heading off
set feedback off
set pagesize 0
set long 500
set SHOW OFF
set linesize 500
set MAXDATA 32760
set ARRAYSIZE 2
select methodtype, lower(name), lower(classname)
from grogmethod
where lower(classname) in ( $baseclasses )
order by decode( lower(classname), lower('${CLASSNAME}'), 0, 1)
/
quit
EOT
   done | while read method_type method_name class_name
      do
         method_type=`echo $method_type`
         method_name=`echo $method_name`
         class_name=`echo $class_name`

         echo "   ${method_type:-'t_GrogReturnType'} ("'*'"$method_name)();"

         echo "${MetaObjectInit:+$MetaObjectInit,}/* $method_name */ t_${class_name}_$method_name\c" >> $META_INIT_FILE


         if [ "$class_name" = "${CLASSNAME}" ]
         then

      if [ "$NO_METHOD_STUBS" = 0 ]
      then
            case $method_type 
            in
            void)
               cat >>$METHODS_TMP_FILE <<EOT

   /*
    * Method: $method_name()
    */

static $method_type t_${class_name}_${method_name}( self )
t_${CLASSNAME} *self;
{
   return;
}
EOT
            cat >> $SourceFile <<EOT

   { extern $method_type t_${CLASSNAME}_$method_name();
     buf->$method_name = t_${CLASSNAME}_$method_name; }
EOT
            ;;
            int|long|double|float|char|enum|t_GrogReturnCode)
               cat >>$METHODS_TMP_FILE <<EOT

   /*
    * Method: $method_name() returning $method_type
    */

static $method_type t_${class_name}_${method_name}( self )
t_${CLASSNAME} *self;
{
   $method_type returnCode=($method_type)GROG_NULL;

   return( returnCode );
}
EOT
            cat >> $SourceFile <<EOT

   { extern $method_type t_${CLASSNAME}_$method_name();
     buf->$method_name = t_${CLASSNAME}_$method_name; }
EOT
            ;;
            $CLASSNAME)
               cat >>$METHODS_TMP_FILE <<EOT

   /*
    * Method: $method_name() returning $method_type*
    */

static $method_type *t_${class_name}_${method_name}( self )
t_${CLASSNAME} *self;
{
   $method_type *returnCode=($method_type*)self;

   return( returnCode );
}
EOT
            cat >> $SourceFile <<EOT

   { extern $method_type *t_${CLASSNAME}_$method_name();
     buf->$method_name = t_${CLASSNAME}_$method_name; }
EOT
            ;;
            *)
               cat >>$METHODS_TMP_FILE <<EOT

   /*
    * Method: $method_name() returning $method_type*
    */

static $method_type *t_${class_name}_${method_name}( self )
t_${CLASSNAME} *self;
{
   $method_type *returnCode=($method_type*)GROG_NULL;

   return( returnCode );
}
EOT
            cat >> $SourceFile <<EOT

   { extern $method_type *t_${CLASSNAME}_$method_name();
     buf->$method_name = t_${CLASSNAME}_$method_name; }
EOT
            ;;
            esac
          fi

         else

      if [ "$NO_METHOD_STUBS" = 0 ]
      then
            cat >> $SourceFile <<EOT

   { extern $method_type t_${class_name}_$method_name();
     buf->$method_name = t_${class_name}_$method_name; }
EOT
      fi
         fi

         echo "   $method_name   \c" >&2
         mcount=mcount+1
      done
   fi

   if [ $mcount -eq 0 ]
   then
      if [ "$NO_METHOD_STUBS" = 0 ]
      then
      echo "   /* <NO METHOD MEMBERS DECLARED FOR ${CLASSNAME}> */" | tee -a \
         $SourceFile
      fi
      echo "   <NO METHOD MEMBERS DECLARED FOR ${CLASSNAME}>" >&2
   fi

   echo "" >&2

}
