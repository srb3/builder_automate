#!/bin/bash

cat << EOF >> /tmp/install.sh
#!/bin/bash
umask 0022

pushd scripts > /dev/null
./install-hab.sh
./hab-sup.service.sh
./provision.sh
popd > /dev/null
EOF

chmod +x /tmp/install.sh

cat << EOF >> /tmp/bldr.env
#!/bin/bash
export MINIO_ENDPOINT=http://localhost:9000
export MINIO_BUCKET=habitat-builder-artifact-store.local
export MINIO_ACCESS_KEY=depot
export MINIO_SECRET_KEY=password
export APP_SSL_ENABLED=false
export APP_URL=http://builder_fqdn
export OAUTH_PROVIDER=chef-automate
export OAUTH_USERINFO_URL=https://automate_fqdn/session/userinfo
export OAUTH_AUTHORIZE_URL=https://automate_fqdn/session/new
export OAUTH_TOKEN_URL=https://automate_fqdn/session/token
export OAUTH_REDIRECT_URL=http://builder_fqdn/
export OAUTH_CLIENT_ID=oauth_id
export OAUTH_CLIENT_SECRET=oauth_secret
export BLDR_CHANNEL=on-prem-stable
export BLDR_ORIGIN=habitat
export ANALYTICS_ENABLED=false
export ANALYTICS_COMPANY_NAME=""
EOF

sudo rm -f /root/on-prem-builder/bldr.env
sudo rm -f /root/on-prem-builder/install.sh

sudo cp /tmp/install.sh /root/on-prem-builder/install.sh
sudo cp /tmp/bldr.env /root/on-prem-builder/bldr.env
sudo cp -r /root/on-prem-builder /tmp
sudo chown -R centos:centos /tmp/on-prem-builder
cd /tmp/on-prem-builder
sudo ./install.sh
