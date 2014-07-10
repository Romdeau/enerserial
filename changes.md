ORDER
stock
# ppsr
import
# actionmailer


BRANCHES
# actionmailer
#  Set “ready to ship” trigger to email to generate a PPSR.
devise
import
	Write import for existing data.
job
layout
logging
master
# ppsr
	PPSR does need a serial number.
#	PPSR Expiry Date and Reminder
scaffold
stock
	VIN Number Field
	Gesan Number - Manufacturers Number
	Set Shipping Date for ready to ship, enforce.
stylesheet
	Break up Display for status Visually.
supplier

COMMENTS
	enforcing a shipping date for ready to ship doesn’t make sense, something could be ready to ship but not necessarily have a shipping date. Adding Assertion to Dispatched.

Meeting 10/7/14

BRANCHES
# Main Register Sorting

# put new button up the top

# granular user levels Admin->Editor->ReadOnly

# edit form rename Gesan Number to Manufacturers Number

# 1405016 - Missing Engine and Alternator

Order -> Order Acknowledgement -> Invoice (serial numbers start here)

# Status
#  Order number field into Stock
#  Remove serial number validate: exists from Stock.

# Orders
rails g scaffold order order_number:string
#  Build Generator to translate "week 5" into the date for Wednesday.
#  Order has multiple items on it.
#    Ordered - Single order has_many: Stock Items with only model numbers. Stock item has status Ordered.
#    Acknowledged - Estimated Shipping Date for whole order

# Serial Numbers
