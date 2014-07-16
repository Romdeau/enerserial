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
#  Order number field into Stock.
#  Remove serial number validate: exists from Stock.
#  Stock Items need a floor stock system.
#  Stock needs a Location Field.

# Orders
rails g scaffold order order_number:string shipping_date:date
rails g migration #add order:references to stock
#  Build Generator to translate "week 5" into the date for Wednesday.
  Order has multiple items on it.
    Ordered - Single order has_many: Stock Items with only model numbers. Stock item has status Ordered.
#    Acknowledged - Estimated Shipping Date for whole order
#    Goods Loaded - Suppliers Serial Numbers
#    On The Water - Estimated Arrival Date Email project manager, accounts, factory
#    Arrived - End Point - Goes to Floor Stock or Stock Item. Needs Location Field

# Serial Numbers
#    New Stock -
#    Floor Stock -
#    Job Allocated - Requires Job Number
#    In Production -
#    Ready to Ship - Email out sign off points in order to get to Ready to Dispatch, Accounts email requires PPSR toggle to be off or on.
#    Ready to Dispatch - Can't Set Until all sign off from various people
#    Dispatched -

# Add Ins
#  Stock_Type: Engine, Alternator, Pump,
#  Order:references
#  Distributor: string
#  Manufacturer: string
#  Model: string
#  Serial_Number: string

#  Out on Demo - Location, Sent and Arrival Date

# Branch Off Engines & Alternators into a generic addon spinoff.
