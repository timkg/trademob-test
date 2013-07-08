# Trademob node.js dev test

## Dependencies:
 - mysql
 - redis
 - mocha

## Known bugs:
 - mysql closes connection after +- 10sec and crashes process. Use connection pool?

## To run tests:
npm test

## To run server:
npm start

## Assumptions:
Coupon server accepts requests over HTTP from an internal VPN, all requests are thus to be considered as coming
coming from a trusted source

## The following set of information needs to be provided for each coupon request:
 - user IP (string)
 - campaign id (int)
