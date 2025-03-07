#!/bin/bash
set -e

host=$1
freemyip_token=$2

# build url
url="https://freemyip.com/update?token=$token&domain=$host.freemyip.com"

# setup cron job
cat > /etc/cron.daily/freemyip <<EOF
#!/bin/bash
set -e
date >> /var/log/cron-freemyip.log
curl '$url' >> /var/log/cron-freemyip.log 2>&1
EOF
chmod a+x /etc/cron.daily/freemyip

# call cron job immediatly
/etc/cron.daily/freemyip

# setup hostname
echo $host > /etc/hostname
hostname $host