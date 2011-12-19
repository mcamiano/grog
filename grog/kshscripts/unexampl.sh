#:!/bin/ksh
# unexample.sh: Remove the extended example of how the GROG would be used.
# $1=GROG username/password to be used for the example base tables
#

# Provide a simple check for parameters
#
if [ -z "$1" ]
then
	echo "$0: Error.  Username/Password missing." >&2
	exit 1
fi

USERNAME=`basename $1`

# Call SQL*Plus to drop example base tables
#
sqlplus -s $1 <<EOT
/*
	Tables used in the GROG Example
*/
drop Table Customer
/
drop Table PlacedOrder
/
drop Table Product
/
drop Table OrderedProduct
/
drop Sequence OrderNumber
/
drop Sequence CustomerID
/
connect johndoe/johndoe
/
drop view Customer
/
drop view PlacedOrder
/
drop view Product
/
drop view OrderedProduct
/
drop view CODOrder
/
drop view PrepaidOrder
/
connect $1
/
delete from grogmethod where name = 'ReceivePayment' and classname = 'PlacedOrder'
/
delete from grogmethod where name = 'ReceivePayment' and classname = 'CODOrder'
/
delete from grogmethod where name = 'ReceivePayment' and classname = 'PrepaidOrder'
/
delete from grogmethod where name = 'AddProductToOrder' and classname = 'PlacedOrder'
/
delete from grogmethod where name = 'ShipProduct' and classname = 'OrderedProduct'
/
revoke dba from JohnDoe
/
revoke connect from JohnDoe
/
EOT
