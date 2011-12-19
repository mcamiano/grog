# crcl.sh: Create a GROG class declaration
#
# $1=Oracle username/password
# $2=application name
sqlplus -s $1 <<EOT
set feedback off
grant connect to $2 identified by $2
/
grant dba to $2
/
quit
/
EOT
