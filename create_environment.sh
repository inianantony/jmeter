#!/bin/bash -e

# --------------------------------
echo "Create jmeter db in influxdb"

influxdb_pod=`kubectl get pods | grep influxdb-jmeter | awk '{print $1}'`
kubectl exec -ti $influxdb_pod -- influx -execute 'CREATE DATABASE jmeter'
# --------------------------------

# --------------------------------
echo "Make load test script in Jmeter master pod executable"

master_pod=`kubectl get pods | grep jmeter-master | awk '{print $1}'`
kubectl exec -ti $master_pod -- cp -r /load_test /jmeter/load_test
kubectl exec -ti $master_pod -- chmod 755 /jmeter/load_test
# --------------------------------

# --------------------------------
echo "Creating the Influxdb data source in grafans pod"

grafana_pod=`kubectl get pods | grep jmeter-grafana | awk '{print $1}'`
kubectl exec -ti $grafana_pod -- \
curl 'http://admin:admin@127.0.0.1:3000/api/datasources' \
-X POST -H 'Content-Type: application/json;charset=UTF-8' \
--data-binary \
'{"name":"jmeterdb","type":"influxdb","url":"http://jmeter-influxdb:8086","access":"proxy","isDefault":true,"database":"jmeter","user":"admin","password":"admin"}'
# --------------------------------
