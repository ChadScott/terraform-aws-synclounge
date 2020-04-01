#!/bin/bash

set -e

cd /opt/synclounge

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose

while [ "$(systemctl is-active docker)" != "active" ]; do sleep 1; done

export WEB_ACCESSURL=${1-http://$(curl http://169.254.169.254/latest/meta-data/public-ipv4)}
export AUTOJOIN_ENABLED=true
export AUTOJOIN_SERVERURL=${WEB_ACCESSURL}/slserver
export AUTOJOIN_ROOM="${2}"
export AUTOJOIN_PASSWORD="${3}"

docker-compose up -d
