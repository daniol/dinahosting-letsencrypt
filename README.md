# Let's Encrypt - [Dinahosting](https://dinahosting.com/?affref=5F664727881E1)
Let's Encrypt validation hook for [Dinahosting](https://dinahosting.com/?affref=5F664727881E1) DNS.

## Requirements

* Active domain registered with [Dinahosting](https://dinahosting.com/?affref=5F664727881E1)
* Valid [Dinahosting](https://dinahosting.com/?affref=5F664727881E1) API credentials
* Linux OS
* [Certbot](https://certbot.eff.org/)
* CURL
* [jq](https://stedolan.github.io/jq/)

Installation of dependencies on Ubuntu/Debian:

```
apt-get update
apt-get install certbot curl jq git
```

## How to obtain Dinahosting API

1. [Register for Dinahosting API access on this URL](https://dinahosting.com/api/?affref=5F664727881E1)
2. Use thec ontrol panel access details as API credentials

## Installation

Execute the following command to download the scripts to some folder **which is only readable by root**:

```
git clone https://github.com/daniol/dinahosting-letsencrypt.git
```

## Configuration

Edit the file `dinahosting_vars.sh` and set the API credentials. 

* `API_USER` is the user name you use to log in to the customer panel.
* `API_PASS` is the password to the customer panel.

## How to configure a wilcard domain with automatic renew

The following example creates a certificate for example.com and all subdomains (*.example.com). Don't forget to write the full path to the `manual-auth-hook` and `manual-cleanup-hook` scripts.

```
certbot certonly --manual -d *.example.com -d example.com \
 --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 \
 --server https://acme-v02.api.letsencrypt.org/directory \
 --manual-auth-hook /root/dinahosting-letsencrypt/dinahosting_auth.sh  \
 --manual-cleanup-hook /root/dinahosting-letsencrypt/dinahosting_cleanup.sh
```

### Configure apache virtualhost

Add the following in the virtualhost configuration file (between &lt;VirtualHost&gt; and &lt;/VirtualHost&gt;): 

```
SSLCertificateFile /etc/letsencrypt/live/example.com/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/example.com/privkey.pem
Include /etc/letsencrypt/options-ssl-apache.conf
```

### Configure autorenew

Add a cron task to `certbot renew` to be executed once a week, for example:

```
0 0 * * 0 certbot renew --quiet --agree-tos --post-hook "service apache2 reload" >/dev/null 2>&1
```
