# showm.sh: Show defined methods
#
# $1=Oracle username/password
# $2=class name
#
echo "Class: $2"

sqlplus -s $1 <<EOT | grep -v "^$"
set heading off
set feedback off
select methodtype, name from grogmethod where upper(classname) = upper('$2')
/
quit
/
EOT
