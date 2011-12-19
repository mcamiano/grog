#:!/bin/ksh
# example.sh: Provide an extended example of how the GROG would be used.
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

# Call SQL*Plus to create example base tables
#
sqlplus -s $1 <<EOT
/*
	Tables used in the GROG Example
*/
Create Table Customer
(
	ID   Integer,
	SurName   Char(50),
	SubName   Char(50) 
);
Create Table PlacedOrder
(
	OrderNumber   Integer,
	PaymentMethod   Char(10),
	OriginDateTime   Date
);
Create Table Product
(
   Code   Char(10),
	Description   Char(80) 
);
Create Table OrderedProduct
(
	OrderNumber   Integer,
	ProductCode   Char(10),
   CountOrdered  Integer,
   OriginDateTime  Date,
   ShipDateTime  Date
);
/*
	Sequencer for order numbers
*/
Create Sequence OrderNumber
Increment By 1
Start With 5000
NoMaxValue
NoMinValue
NoCycle
NoCache
NoOrder;

/*
	Sequencer for customer identifiers
*/
Create Sequence CustomerID
Increment By 1
Start With 1000
NoMaxValue
NoMinValue
NoCycle
NoCache
NoOrder;
EOT

# Create a GROG connection, JohnDoe/JohnDoe, for a class hierarchy
#
crch.sh $1 JohnDoe

# Create GROG classes to correspond directly to base tables
#
for table in Customer PlacedOrder Product OrderedProduct
do
   crcl.sh JohnDoe/JohnDoe $table "$USERNAME.$table"
done

# Declare new methods for the Order class
#
crm.sh JohnDoe/JohnDoe PlacedOrder ReceivePayment tGrogReturnCode
crm.sh JohnDoe/JohnDoe PlacedOrder AddProductToOrder tGrogReturnCode
crm.sh JohnDoe/JohnDoe OrderedProduct ShipProduct tGrogReturnCode

# Create GROG classes to correspond to specializations of Order
#
crcl.sh JohnDoe/JohnDoe CODOrder PlacedOrder "PaymentMethod = 'COD'"
crcl.sh JohnDoe/JohnDoe PrepaidOrder PlacedOrder "PaymentMethod = 'PREPAID'"

# Declare (override) methods for the specialization classes
#
crm.sh JohnDoe/JohnDoe CODOrder ReceivePayment tGrogReturnCode
crm.sh JohnDoe/JohnDoe PrepaidOrder ReceivePayment tGrogReturnCode

# Export the declarations to source code files. 
# Note that the overridden methods for CODOrder and PrepaidOrder 
#    would be defined by externally defined C or PRO*C functions, and/or
#    by recoding of the function stubs created by grogexp.sh
#
grogexp.sh  JohnDoe/JohnDoe
