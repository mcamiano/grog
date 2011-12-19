#!/bin/ksh
# 
# Copyright 1993 by Mitch C. Amiano
# All Rights Reserved
#

dumpdmembers() {
   CLASSNAME=$1

   integer osize

   echo "Exporting data members for $CLASSNAME" >&2

   for i in 1
   do
      MetaObjectInit=""
      sqlplus -s $LOGNAME/$LOGNAME <<EOT   
set heading off
set feedback off
set pagesize 0
set long 500
set SHOW OFF
set linesize 500
set MAXDATA 32760
set ARRAYSIZE 2
select 
   lower(data_type), 
   lower(column_name), 
   data_length, 
   data_precision, 
   data_scale
from user_tab_columns
where lower(table_name) = lower('$CLASSNAME')
order by column_id
/
quit
/
EOT
   done | while read data_type column_name data_length data_precision data_scale
      do
         data_type=`echo $data_type`
         column_name=`echo $column_name`
         data_length=`echo $data_length`
         data_precision=`echo $data_precision`
         data_scale=`echo $data_scale`

         output=""
         otype=""
				 osize=0
         ddecl=""
         dcopy=""
         dreference=""
         dname=""
         print_ref=""

				 del_clause="         "${MetaObjectInit:+" And "}"( $column_name = :l${column_name} or ( :l${column_name} Is Null And $column_name Is Null ) )" 
         case "$data_type" in
         varchar|char)
            otype="char"
						osize=$data_length+1
            ddecl="varchar l$column_name[$osize];"
            dcopy="strcpy(l$column_name.arr, object->$column_name);"
            dreference=${MetaObjectInit:+", "}" :l$column_name"
            dname=${MetaObjectInit:+", "}" $column_name"
            MetaObjectInit="${MetaObjectInit}/* $column_name */ \"\","
            output="$otype $column_name[$osize];"
            print_ref='printf("%*.*s"'", sizeof(object->$column_name), sizeof(object->$column_name), object->$column_name );"
         ;;
         integer) 
            otype="int"
            dcopy="l$column_name=object->$column_name;"
            ddecl="int l$column_name;"
            dreference=${MetaObjectInit:+", "}" :l$column_name"
            dname=${MetaObjectInit:+", "}" $column_name"
            MetaObjectInit="${MetaObjectInit}/* $column_name */ 0,"
            output="$otype $column_name;"
            print_ref='printf("%d"'", object->$column_name );"
         ;;
         number)
            otype="double"
            dcopy="l$column_name=object->$column_name;"
            ddecl="double l$column_name;"
            dreference=${MetaObjectInit:+", "}" :l$column_name"
            dname=${MetaObjectInit:+", "}" $column_name"
            MetaObjectInit="${MetaObjectInit}/* $column_name */ ($otype) 0.0,"
            output="$otype $column_name;"
            print_ref='printf("%g"'", object->$column_name );"
         ;;
         date)
            otype="char"
            dcopy="strcpy(l$column_name.arr, object->$column_name);"
            ddecl="varchar l$column_name[30];"
            dreference=${MetaObjectInit:+", "}" :l$column_name"
            dname=${MetaObjectInit:+", "}" $column_name"
            MetaObjectInit="${MetaObjectInit}/* $column_name */ \"\","
            output="$otype $column_name[30];"
            print_ref='printf("%*.*s"'", sizeof(object->$column_name), sizeof(object->$column_name), object->$column_name );"
         ;;
         * )
            otype="void"
            dcopy="l$column_name=*object->$column_name;"
            ddecl="$data_type l$column_name;"
            dreference=${MetaObjectInit:+", "}" :l$column_name"
            dname=${MetaObjectInit:+", "}" $column_name"
            MetaObjectInit="${MetaObjectInit}/* $column_name */ ($otype \*) NULL,"
            output="$otype *$column_name;"
            print_ref='printf("%0.0s", "");'" /* void object->$column_name */"
         ;;
         esac

         echo "   $output" 
         echo "   $print_ref" >> $PRINT_MEMBER_FILE
         echo "      $ddecl" >> $HOST_DECLARE_FILE
         echo "   $dcopy" >> $HOST_COPY_FILE
         echo "         $dreference" >> $HOST_REFERENCE_FILE
         echo "$del_clause" >> $DELETE_FILE
         echo "         $dname" >> $HOST_NAME_FILE
         echo "   t_GrogReturnCode (*${column_name}_is_valid)();" >> $VMEMBERS_FILE
         echo "   t_${CLASSNAME}_${column_name}_is_valid, ">>$META_VALIDATE_FILE
				 cat <<EOT >>$VCONSTRUCTS_FILE

   { buf->${column_name}_is_valid=t_${CLASSNAME}_${column_name}_is_valid; }
EOT
         echo "      returnCode = object->${column_name}_is_valid();\n      if ( returnCode != GROG_SUCCESS ) break;" >> $VALIDATE_FILE
         cat <<EOT >>$VDEFS_FILE
   /*
    * Method to validate $column_name member
    */

t_GrogReturnCode t_${CLASSNAME}_${column_name}_is_valid( object )
{
   t_GrogReturnCode returnCode = (t_GrogReturnCode) GROG_SUCCESS;

   return( returnCode );
}

EOT

      done
      echo "\n" >> $HOST_REFERENCE_FILE
      echo "\n" >> $HOST_NAME_FILE
      echo "$MetaObjectInit" >> $META_INIT_FILE
      cat <<EOT

   /*
    * Pointer to self, implicit in the design
    */
   struct s_${CLASSNAME} *self;

   GROG_MACRO_VALIDATION_MEMBERS

EOT
   echo "   /* self */ (t_${CLASSNAME} *) &${CLASSNAME}\c" >> $META_INIT_FILE
   MetaObjectInit=" "
}
