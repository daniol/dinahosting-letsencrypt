#!/bin/bash

# Include credentials from file
source dinahosting_vars.sh

# Create TXT record
responseCode=$( curl -s "https://dinahosting.com/special/api.php?AUTH_USER=$API_USER&AUTH_PWD=$API_PASS&command=Domain_Zone_AddTypeTXT&domain=$CERTBOT_DOMAIN&hostname=_acme-challenge&text=$CERTBOT_VALIDATION&responseType=json&SIMULATE=false" | jq -r '.responseCode' )
echo "Creating TXT-Entry to $CERTBOT_DOMAIN: $responseCode"
[[ "$responseCode" = "1000" ]] || exit 1

# Sleep to make sure the change has time to propagate over to DNS (Dinahosting TXT TTL: 5 min)
sleep 6m

exit 0
