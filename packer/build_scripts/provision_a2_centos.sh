#!/bin/bash
set -e
set -u

PACKAGES=(curl gzip jq vim)
CA_BIN="/usr/local/bin/chef-automate"
CONFIG_FILE="/root/config.toml"
A2_URL="https://packages.chef.io/files/current/latest/chef-automate-cli/chef-automate_linux_amd64.zip"
CHEF_VERSION="13.12.3"

function run_cmd() {
  echo "$1" >> /tmp/command_log
  eval "$1" | tee -a /tmp/install_log &>/dev/null
}

function g_command() {
  cmd=$(printf "%s" "${*}")
  run_cmd "${cmd}"
}

function set_sysctl() {
  current_val=$(sysctl ${1} | awk -F '=' '{print $2}' | tr -d ' ')
  if [[ ${current_val} != "${2}" ]]; then
    g_command sysctl -w ${1}=${2}
    g_command echo "${1}=${2}" ">>" /etc/sysctl.conf
  fi
}

function curl_unzip() {
  if [[ ! -f ${2} ]]; then
    g_command curl ${1} "|" gunzip "-" ">" ${2}
  fi
}

function install_yum() {
  if ! rpm -q ${1} &>/dev/null; then
    g_command yum install -y ${1}
  fi
}

function make_exec() {
  if [[ ! -x ${1} ]]; then
    g_command chmod +x ${1}
  fi
}

function create_token_a2_server() {
  g_command chef-automate admin-token ">" /root/.admin_token
}

for i in ${PACKAGES[@]}; do
  install_yum $i
done

curl_unzip ${A2_URL} ${CA_BIN}
make_exec ${CA_BIN}

set_sysctl vm.max_map_count 262144
set_sysctl vm.dirty_expire_centisecs 20000

if [[ ! -f ${CONFIG_FILE} ]]; then
  g_command ${CA_BIN} init-config --file ${CONFIG_FILE} --upgrade-strategy none
fi

if [[ ! -d /hab ]]; then
  g_command ${CA_BIN} deploy --accept-terms-and-mlsa ${CONFIG_FILE}
fi

create_token_a2_server
