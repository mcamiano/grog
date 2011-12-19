# delc.sh: Delete class declaration 
#
# $1=Oracle user/password
# $2=class name
# $3=method name
# $4=method data type

sqlplus -s $1 <<EOT
set feedback off
delete from grogmethod where upper(classname) = upper('$2')
/
drop view $2
/
quit
/
EOT
