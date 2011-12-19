#
# $1=class name
# $2=base table name
sqlplus -s $LOGNAME/$LOGNAME <<EOT
create synonym $1 for $2
/
quit
/
EOT
