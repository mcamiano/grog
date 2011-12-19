# uninstall.sh: Remove the GROG system tables from the default database
#
# $1=Oracle username/password
sqlplus -s $1 <<EOT
drop table grogmethod
/
drop view grogclass
/
EOT
