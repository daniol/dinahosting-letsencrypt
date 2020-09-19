# Let's Encrypt - [Dinahosting](https://dinahosting.com/?affref=5F664727881E1)
Let's Encrypt validation hook for [Dinahosting](https://dinahosting.com/?affref=5F664727881E1) DNS.

## Requirements

* Linux OS
* [https://certbot.eff.org/](Certbot)
* CURL
* jq

Installation of dependencies on Ubuntu/Debian:

```
apt-get update
apt-get install certbot curl jq git
```

## Installation

Execute the following command to download the scripts to some folder:

```
git clone https://github.com/daniol/dinahosting-letsencrypt.git
```

## Configuration

Edit the file `dinahosting_vars.sh` and set the API credentials. 

`API_USER` is the user name you use to log in to the customer panel.

`API_PASS` is the password to the customer panel.

## How to configure a wilcard domain with automatic renew

The following example adds a certificate to example.com and all subdomains. Don't forget to write the full path to the `manual-auth-hook` and `manual-cleanup-hook` scripts.

```
certbot certonly --manual -d *.example.com -d example.com \
 --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 \
 --server https://acme-v02.api.letsencrypt.org/directory \
 --manual-auth-hook /root/dinahosting_auth.sh  \
 --manual-cleanup-hook /root/dinahosting_cleanup.sh
```

### Configure apache virtualhost

Add the following in the virtualhost configuration file (between &lt;VirtualHost&gt; and &lt;/VirtualHost&gt;): 

```
SSLCertificateFile /etc/letsencrypt/live/example.com/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/example.com/privkey.pem
Include /etc/letsencrypt/options-ssl-apache.conf
```
