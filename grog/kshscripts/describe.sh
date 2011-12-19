# describe.sh: Describe an Oracle database entity
#
# $1=Oracle username/password
# $2=entity name
#
sqlplus -s $1 <<EOT | grep -v "^$"
set heading off
set feedback off
describe $2
quit
/
EOT
