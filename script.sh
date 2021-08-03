#! /bin/bash

set -ev

# Logger
. ./color-logger.bash

for run in {1..10}; do
  warn "Run $run of 10"

  info "Running traceroute to github.com..."
  time traceroute github.com

  info "Curling a docker-compose release from github..."
  time curl -sSfLv https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` > docker-compose

  rm -fr docker-compose

  info "Cloning this repo (https)..."
  time git clone https://github.com/blimmer/travis-ci-example.git

  rm -fr travis-ci-example

  info "Running a traceroute to registry-1.docker.io..."
  time traceroute registry-1.docker.io

  info "Running apt-key for yarn..."
  time sudo apt-key adv --fetch-keys http://dl.yarnpkg.com/debian/pubkey.gpg

  info "Pulling from Docker Hub..."
  time docker --debug --log-level "debug" pull pmem/libpmemobj-cpp:ubuntu-16.04

  docker rmi pmem/libpmemobj-cpp:ubuntu-16.04
done

cat /etc/resolv.conf
netstat -rna
