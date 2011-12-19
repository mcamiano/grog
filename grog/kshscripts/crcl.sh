# crcl.sh: Create a GROG class declaration
#
# $1=Oracle username/password
# $2=class name
# $3=base table name
# $4=optional "WHERE ..." clause 
WHERECLAUSE=$4
if [ -z "$WHERECLAUSE" ]
then
sqlplus -s $1 <<EOT
set feedback off
create view $2 as 
select * 
from $3
/
quit
/
EOT
else
sqlplus -s $1 <<EOT
set feedback off
create view $2 as 
select * 
from $3 
where $WHERECLAUSE
/
quit
/
EOT
fi
