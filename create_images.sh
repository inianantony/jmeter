#!/bin/bash -e

docker build -t app_bookservice:latest -f dockerfiles/app.Dockerfile .
docker build -t jmeter_base:latest -f dockerfiles/jmeterbase.Dockerfile .
docker build -t jmeter_master:latest -f dockerfiles/jmetermaster.Dockerfile .
docker build -t jmeter_slave:latest -f dockerfiles/jmeterslave.Dockerfile .