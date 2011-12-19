# install.sh: Install the GROG system tables in the default database
#
# $1=Oracle username/password
sqlplus -s $1 @grog.sql
