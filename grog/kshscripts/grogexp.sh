#!/bin/ksh
# Korn Shell script to generate C class structures, function definitions, 
#   and CPP macro definitions from RDBMS data dictionary + ancillary tables
#
# Input: 
#   $1 = username/password
#   $2 = [-nms]
#   Where nms=Do not generate method stubs
#
# Output: "classname".(extention)   source file - class definitions and stubs
#         "classname".(extention)   header file - class declarations and macros
PROGNAME=$0
TODAY=`date +%D`
GROG_RET_TYPE="int"
GROG_SUCCESS="GROG_SUCCESS"
GROG_FAILURE="GROG_FAILURE"
HEADER_PATH="./include"
HEADER_SUFFIX=".h"
SOURCE_PATH="./src"
SOURCE_SUFFIX=".pc"
TMP_DIR="./tmp"
METHODS_TMP_FILE="$TMP_DIR/methods"
MetaObjectInit=""
META_INIT_FILE="$TMP_DIR/meta"
NO_METHOD_STUBS=0
SourceTmpFile="$TMP_DIR/source_tmp"
HeaderTmpFile="$TMP_DIR/header_tmp"
HOST_DECLARE_FILE="$TMP_DIR/declare"
HOST_COPY_FILE="$TMP_DIR/copy"
HOST_REFERENCE_FILE="$TMP_DIR/reference"
HOST_NAME_FILE="$TMP_DIR/name"
VDEFS_FILE="$TMP_DIR/vdefs"
VMEMBERS_FILE="$TMP_DIR/vmembers"
VALIDATE_FILE="$TMP_DIR/valdatecalls"
DELETE_FILE="$TMP_DIR/del_file"
VCONSTRUCTS_FILE="$TMP_DIR/vconstructs"
META_VALIDATE_FILE="$TMP_DIR/metav"
PRINT_MEMBER_FILE="$TMP_DIR/print_members"
USERNAME=$1

if [ ${2:-"null"} = "-nms" ]
then
	 NO_METHOD_STUBS=1
fi

fatalError() {
   echo "$PROGNAME: $*"
   exit -1
}

. dmpd.sh
. dmpm.sh
. dmpc.sh

grogdump() {

   if [ ! -d "$TMP_DIR" ]
   then 
      mkdir $TMP_DIR
   fi

   if [ ! -d "$SOURCE_PATH" ]
   then 
      mkdir $SOURCE_PATH
   fi

   if [ ! -d "$HEADER_PATH" ]
   then 
      mkdir $HEADER_PATH
   fi

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
select distinct(Name)
from GrogClass
/
quit
EOT

   done | while read ClassName
      do
         echo "" > $META_INIT_FILE
         ClassName=`echo $ClassName`
         dumpclass ${ClassName}
      done
}

grogdump
