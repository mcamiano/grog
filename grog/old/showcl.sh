# showcl.sh: Show defined classes
#
# $1=Oracle username/password
#
sqlplus -s $1 <<EOT | grep -v "^$"
set heading off
set feedback off
select synonym_name from user_synonyms
/
quit
/
EOT
