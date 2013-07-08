Trademob node.js dev test

To run tests:
    mocha --compilers coffee:coffee-script

Assumptions
Coupon server accepts requests over HTTP from an internal VPN, all requests are thus to be considered as coming
from a trusted source

The following set of information is provided for each coupon request:
 - user IP
 - campaign id
