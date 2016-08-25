#!/bin/sh

echo "Preparing environment..."
echo '#!/bin/sh' > /environment.sh
echo "export CA=${CA}" >> /environment.sh
echo "export DOMAINS='${DOMAINS}'" >> /environment.sh
echo "export NO_CERT_UPDATES=${NO_CERT_UPDATES}" >> /environment.sh

echo "Starting crond in the background..."
cron

/configure-hosts.sh

echo "Starting nginx in the background..."
nginx &
sleep 2

echo "Checking certs..."
/update-certs

echo "Stopping nginx..."
nginx -s quit
sleep 5

echo "Starting nginx..."
nginx -g "daemon off;"
