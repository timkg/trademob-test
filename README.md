# Trademob node.js dev test

## Dependencies:
 - mysql
 - redis
 - mocha

## Known bugs:
 - mysql closes connection after +- 10sec and crashes process. Use connection pool?

## Assumptions:
Coupon server accepts requests over HTTP from an internal VPN, all requests are thus to be considered as coming from
a trusted source

## Usage

**To run tests:**
npm test

**To run server:**
npm start

**The following set of information needs to be provided for each coupon request:**
 - user IP (string)
 - campaign id (int)

** To issue a coupon request:**
 - HTTP GET to http://serverhost/coupon, passing **campaign_id** and **user_ip** as query string parameters