#!/bin/bash

#Informs the user if the account was not able to be created. If theaccount is not created,
#the script is to return an exit status of 1.  All messages associated with this event 
#will be displayed on standard error. Suppresses the output from all other commands. Displays
#the username, password, and the hostname of the server where the account was created.  

usage ()
    {  
        echo >&2
	echo "Usage: ${0} [DOMAIN] [IP ADDRESS]" >&2
        echo "This script uses curl to query a domain/server for TLS data"
	echo "For example to bypass proxy and query the origin server:"
	echo " ${0} [DOMAIN] [IP ADDRESS]" >&2
	echo >&2
    }  


#Function that checks certain commands and exit if in error.

if [[ -z ${@} ]]
then
    usage
    exit 1
fi

#Uses the first argument provided on the command line as the domain-name for the curl command.  

DOMAINNAME=${1}

#Any remaining arguments on the command line will be treated as the origin IP Address.

shift
IPADDRESS="${@}"

#Query the origin server and display the data of the TLS handshake and connection info.

curl -svo /dev/null https://${DOMAINNAME} --connect-to ::${IPADDRESS} 2>&1 | egrep -v "^{.*$|^}.*$|^* http.*$"

exit 0

