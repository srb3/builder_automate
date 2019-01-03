#!/bin/bash
set -e
set -u

PACKAGES=(curl git vim)

REPO=https://github.com/habitat-sh/on-prem-builder.git
LOCAL_REPO=/root/on-prem-builder

INSTALL_CMD="yes|./install.sh"
INSTALL_LOCK=/root/run_once

ENV_SAM="${LOCAL_REPO}/bldr.env.sample"
ENV_FILE="${LOCAL_REPO}/bldr.env"

IPV4=$(hostname -i)

GITHUB_ADDR=github.com
GITHUB_APP_CB="OAUTH_REDIRECT_URL=http://${IPV4}/"
GITHUB_API_URL=https://api.github.com
GITHUB_APP_URL="APP_URL=http://${IPV4}"
GITHUB_TOKEN_URL=https://github.com/login/oauth/access_token
GITHUB_CLIENT_ID="OAUTH_CLIENT_ID=8b2bce699eebee540def"
GITHUB_AUTHORIZE_URL=https://github.com/login/oauth/authorize
GITHUB_CLIENT_SECRET="OAUTH_CLIENT_SECRET=deb5987dbc1d4c68ac63ee41cf9c8275354f517b"

OAUTH_APP_URL="APP_URL=http://localhost"
OAUTH_REDIRECT="OAUTH_REDIRECT_URL=http://localhost/"
OAUTH_CLIENT_ID="OAUTH_CLIENT_ID=0123456789abcdef0123"
OAUTH_CLIENT_SECRET="OAUTH_CLIENT_SECRET=0123456789abcdef0123456789abcdef01234567"

function run_cmd() {
  echo "$1" >> /tmp/command_log
  eval "$1" | tee -a /tmp/install_log &>/dev/null
}

function install_yum() {
  if ! rpm -q ${1} &>/dev/null; then
    cmd=$(printf 'echo "install %s"' ${1})
    run_cmd "${cmd}"
    cmd=$(printf "yum install -y %s" ${1})
    run_cmd "${cmd}"
  fi
}

function clone_repo() {
  if [[ ! -d ${1} ]]; then
    cmd=$(printf 'echo "cloning repo %s to %s"' ${2} ${1})
    run_cmd "${cmd}"
    cmd=$(printf "git clone %s %s" ${2} ${1})
    run_cmd "${cmd}"
  fi
}

function copy_file() {
  if [[ ! -f ${2} ]]; then
    cmd=$(printf 'echo "copying file %s to %s"' ${1} ${2})
    run_cmd "${cmd}"
    cmd=$(printf "cp %s %s" ${1} ${2})
    run_cmd "${cmd}"
  fi
}

function line_in_file() {
  if ! grep ${3} ${1}; then
    cmd=$(printf 'echo "replacing %s with %s in %s"' ${2} ${3} ${1})
    run_cmd "${cmd}"
    cmd=$(printf "sed -i 's~%s~%s~' %s" ${2} ${3} ${1})
    run_cmd "${cmd}"
  fi
}

function run_cmd_in_dir() {
  if [[ ! -f ${INSTALL_LOCK} ]]; then
    cmd=$(printf 'echo "running command %s from directory %s"' ${2} ${1})
    run_cmd "${cmd}"
    cmd=$(printf "su -c 'cd %s; %s'" ${1} ${2})
    run_cmd "${cmd}"
    cmd=$(printf "touch %s" ${INSTALL_LOCK})
    run_cmd "${cmd}"
  fi
}

for i in ${PACKAGES[@]}; do
  install_yum $i
done

clone_repo ${LOCAL_REPO} ${REPO}

copy_file ${ENV_SAM} ${ENV_FILE}

line_in_file ${ENV_FILE} ${OAUTH_APP_URL} ${GITHUB_APP_URL}
line_in_file ${ENV_FILE} ${OAUTH_REDIRECT} ${GITHUB_APP_CB}
line_in_file ${ENV_FILE} ${OAUTH_CLIENT_ID} ${GITHUB_CLIENT_ID}
line_in_file ${ENV_FILE} ${OAUTH_CLIENT_SECRET} ${GITHUB_CLIENT_SECRET}

#run_cmd_in_dir ${LOCAL_REPO} ${INSTALL_CMD}
