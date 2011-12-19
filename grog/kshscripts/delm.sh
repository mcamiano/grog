# delm.sh: Delete method declaration 
#
# $1=Oracle user/password
# $2=class name
# $3=method name
# $4=method data type

sqlplus -s $1 <<EOT
set feedback off
delete from grogmethod where upper(class_name) = upper('$2') and 
	upper(method_name) = upper('$3')
/
quit
/
EOT
