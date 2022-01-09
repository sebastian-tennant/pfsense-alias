# pfsense-alias-powershell

I currently run two internet connections, one through Australia's monopoly provider (NBN) - which uses HFC - and another, through Starlink. The NBN connection is a basic 12/1 service, whereas Starlink can go above 200/50.
These are setup as two different failover groups within pfSense - one which has Starlink as the primary link, and NBN as the failover - and vice versa. 

When I'm playing online games, I want my traffic to go out through the NBN connection for lower latency This involves adding it to an alias which has a corresponding rule which routes traffic through the NBN primary gateway group. 

This script allows me to easily enforce traffic through a certain connection as needed. E.g. a 100GB game update comes out - I'd want to do that over the faster link. 
