ORDER
stock
 ppsr
import
 actionmailer


BRANCHES
 actionmailer
 Set “ready to ship” trigger to email to generate a PPSR.
devise
import
	Write import for existing data.
job
layout
logging
master
  ppsr
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
Main Register Sorting - Decided on javascript search.

put new button up the top

granular user levels Admin->Editor->ReadOnly ** Did role based instead

edit form rename Gesan Number to Manufacturers Number

# 1405016 - Missing Engine and Alternator

Order -> Order Acknowledgement -> Invoice (serial numbers start here)

  Status
  Order number field into Stock.
  Remove serial number validate: exists from Stock.
#  Stock Items need a floor stock system.
#  Stock needs a Location Field.
#  Need a better indicator for when adding an invalid job, just says updated successfully at the moment,.

# Orders
rails g scaffold order order_number:string shipping_date:date
rails g migration #add order:references to stock
#  Build Generator to translate "week 5" into the date for Wednesday.
  Order has multiple items on it.
    Ordered - Single order has_many: Stock Items with only model numbers. Stock item has status Ordered.
    Acknowledged - Estimated Shipping Date for whole order
    Goods Loaded - Suppliers Serial Numbers
    On The Water - Estimated Arrival Date Email project manager, accounts, factory
    Arrived - End Point - Goes to Floor Stock or Stock Item. Needs Location Field

  Serial Numbers
    New Stock -
    Floor Stock -
    Job Allocated - Requires Job Number
    In Production -
 		Production Complete - Email out sign off points in order to get to Ready to Dispatch, Accounts email requires PPSR toggle to be off or on.
 		notify_pm(stock, user)
 		notify_accounts(stock, user)

     Ready to Dispatch - Can't Set Until all sign off from various people - email PM
     Dispatched - email PM

# Items
  Determine This from the Live Orders Sheet.
  Item_Name:string      -- Description
  Item_Type:string      --
  Item_Serial:string    -- Serial Number
  Stock_Type:string     --
  Order:references      -- Our Order Number
  Distributor: string   --
  Manufacturer: string  --
  Model: string        --
# i feel like these all belong in order, not item.
#												-- Supplier Order Number
#												-- Ready Ex Manufacturer
#												-- Manufacturers Comments
			  !combined into costing
          							-- Normal Sell Price (is this important?)
												-- Stock sell @ 31 01 14 (what does this even mean?)
												-- Are we worried about price here, or should this just be for exo? If so whats the math?

#  Out on Demo - Location, Sent and Arrival Date

Branch Off Engines & Alternators into a generic item spinoff.

# Work on Responsive Design

 order view, both columns have same name.
 order change doesnt trigger stock status update
# stock details needs extra column for manufacturer
 add a costing model and allow it to be added to items / stock for their cost.
# items and stock on orders need to know if sold or going to stock.
# costings

(foreign currency cost * exchange rate) + 7% Markup

  Implement a combined Calendar View
  rename order generation label to Number of X to Generate
  costings doesnt work
  stock audits need a longer data field
# add costing to item  
# implement new date picker from enerleave
# add location assertion
# paginate search railscast 240
