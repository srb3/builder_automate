#!/bin/bash

sudo chef-automate init-config --file /tmp/setup.toml --fqdn automate_fqdn
sudo chown centos:centos /tmp/setup.toml
grep -v license /tmp/setup.toml > /tmp/temp.toml && mv /tmp/temp.toml /tmp/setup.toml
cat << EOF >> /tmp/setup.toml
[license_control.v1]
[license_control.v1.svc]
license = "$(cat /tmp/.a2_license)"
[elasticsearch.v1.sys.runtime]
heapsize = "automate_es_heap_size"
EOF

cat << EOF >> /tmp/oauth.toml
[session.v1.sys.service]
bldr_signin_url = "http://builder_fqdn/"
bldr_client_id = "oauth_id"
bldr_client_secret = "oauth_secret"
EOF

sudo systemctl stop chef-automate
sudo pkill chef-automate
sudo chef-automate deploy /tmp/setup.toml --skip-preflight --accept-terms-and-mlsa
sudo chef-automate iam admin-access restore automate_admin_password
sudo chef-automate config patch /tmp/oauth.toml
