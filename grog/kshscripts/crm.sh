# crm.sh: Create method declaration 
#
# $1=Oracle user/password
# $2=class name
# $3=method name
# $4=method data type

sqlplus -s $1 <<EOT
set feedback off
insert into grogmethod values ('$2','$3','$4')
/
quit
/
EOT
