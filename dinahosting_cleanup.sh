#!/bin/bash

# Include credentials from file
source $(dirname $0)/dinahosting_vars.sh

# Remove the challenge TXT record(s)
if [ -n "${CERTBOT_DOMAIN}" ]; then
	while : ; do
	 responseCode=$( curl -s "https://dinahosting.com/special/api.php?AUTH_USER=$API_USER&AUTH_PWD=$API_PASS&command=Domain_Zone_DeleteTypeTXT&domain=$CERTBOT_DOMAIN&hostname=_acme-challenge&responseType=json&SIMULATE=false" | jq -r '.responseCode' )
	 echo "Cleaning TXT-Entry: $responseCode"
	 [[ "$responseCode" = "1000" ]] || break
	done
fi

exit 0
