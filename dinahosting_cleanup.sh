#!/bin/bash

# Include credentials from file
source dinahosting_vars.sh

# Remove the challenge TXT record(s)
if [ -n "${DOMAIN}" ]; then

while : ; do
 responseCode=$( curl -s "https://dinahosting.com/special/api.php?AUTH_USER=$API_USER&AUTH_PWD=$API_PASS&command=Domain_Zone_DeleteTypeTXT&domain=$DOMAIN&hostname=_acme-challenge&responseType=json&SIMULATE=false" | jq -r '.responseCode' )
 echo "Cleaning TXT-Entry: $responseCode"
 [[ "responseCode" = "1000" ]] || break
done

fi
