#!/bin/ksh
dumpclass() {

   MetaObjectInit=''

   if [ -z "$1" ]
   then
      fatalError "Error: Base view name is not set."
   else
      CLASSNAME=`echo $1 | \
         tr "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz"  `
   fi

   HeaderFile="${HEADER_PATH}/${CLASSNAME}${HEADER_SUFFIX}"
   SourceFile="${SOURCE_PATH}/${CLASSNAME}${SOURCE_SUFFIX}"

   if [[ -f "$SourceFile" && "$NO_METHOD_STUBS" = 0 || -f "$HeaderFile" ]]
   then
      echo "Warning: target files exist - remove before attempting export." >&2
      echo "   Files: $SourceFile, $HeaderFile " >&2
   else
      echo "Exporting declarations for class ${CLASSNAME}" >&2
			if [ "$NO_METHOD_STUBS" = 0 ]
			then
         >$METHODS_TMP_FILE
         >$HOST_DECLARE_FILE
         >$HOST_COPY_FILE
         >$HOST_NAME_FILE
         >$HOST_REFERENCE_FILE
         >$VALIDATE_FILE
			>$VDEFS_FILE
			>$VCONSTRUCTS_FILE
			>$VMEMBERS_FILE
			>$DELETE_FILE
			>$META_VALIDATE_FILE
			>$PRINT_MEMBER_FILE

         cat > $SourceFile <<EOT
   /*
    * Grog Class Definition File 
    * Dated: $TODAY
    */

   /*
    * Class: ${CLASSNAME}
    */

EOT
			fi

      cat > $HeaderFile <<EOT
#ifndef I_${CLASSNAME}_GROG
#define I_${CLASSNAME}_GROG

   /*
    * Grog Class Declaration File 
    * Dated: $TODAY
    */

#include "grog.h"

   /*
    * Class: ${CLASSNAME}
    */

struct s_${CLASSNAME} {
   /*
    * Data members
    */
EOT

      dumpdmembers ${CLASSNAME} >> $HeaderFile

      cat <<EOT >> $HeaderFile

EOT
      dumpmmembers ${CLASSNAME}| sed "s/^\([ ]*\)t_${CLASSNAME}/\1struct s_${CLASSNAME}/g" >>$HeaderFile
   
      echo "};\ntypedef struct s_${CLASSNAME} t_${CLASSNAME};" >>$HeaderFile
      echo "\nextern t_${CLASSNAME} ${CLASSNAME};\n" >>$HeaderFile
      echo "#endif" >>$HeaderFile

			if [ "$NO_METHOD_STUBS" = 0 ]
			then
      cat <<EOT >>$SourceFile

   return(buf->self);
}

EOT

      cat $METHODS_TMP_FILE >> $SourceFile
      cat <<EOT >>$SourceFile
   /*
    * Meta-object used for construction (and optionally for destruction)
    */

t_${CLASSNAME} ${CLASSNAME} = {
EOT
      echo "   \c" >> $SourceFile
      echo "" >> $META_INIT_FILE

      sed 's/,/&\
   /g' $META_INIT_FILE >> $SourceFile

   cat <<EOT >>$SourceFile

};


EOT

			sed "/GROG_MACRO_HOST_DECLARATIONS/{
r $HOST_DECLARE_FILE
d
}
/GROG_MACRO_COPY_OBJECT_TO_HOST_VARIABLES/{
r $HOST_COPY_FILE
d
}
/GROG_MACRO_HOST_NAMES/{
r $HOST_NAME_FILE
d
}
/GROG_MACRO_HOST_REFERENCES/{
r $HOST_REFERENCE_FILE
d
}
/GROG_MACRO_VALIDATION_CALLS/{
r $VALIDATE_FILE
d
}
/GROG_MACRO_VALIDATION_DEFINITIONS/{
r $VDEFS_FILE
d
}
/GROG_MACRO_DELETE_CLAUSE/{
r $DELETE_FILE
d
}
/GROG_MACRO_VALIDATION_CONSTRUCTS/{
r $VCONSTRUCTS_FILE
d
}
/GROG_MACRO_META_INIT/{
r $META_VALIDATE_FILE
d
}
/GROG_MACRO_PRINT_REFERENCES/{
r $PRINT_MEMBER_FILE
d
}
" $SourceFile > $SourceTmpFile
mv $SourceTmpFile $SourceFile 
#			sed "/GROG_MACRO_/d" $SourceTmpFile > $SourceFile
			fi

			sed "/GROG_MACRO_VALIDATION_MEMBERS/{
r $VMEMBERS_FILE
d
}
" $HeaderFile > $HeaderTmpFile 
mv $HeaderTmpFile $HeaderFile

   fi
}
