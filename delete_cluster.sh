#!/bin/bash -e

echo "Creating Application Book Service"

kubectl delete  -f k8s_objects/app_deploy.yaml

kubectl delete  -f k8s_objects/app_svc.yaml

echo "Creating Jmeter Slaves"

kubectl delete  -f k8s_objects/jmeter_slaves_deploy.yaml

kubectl delete  -f k8s_objects/jmeter_slaves_svc.yaml

echo "Creating Jmeter Master"

kubectl delete  -f k8s_objects/jmeter_master_configmap.yaml

kubectl delete  -f k8s_objects/jmeter_master_deploy.yaml

echo "Creating Influxdb and the service"

kubectl delete  -f k8s_objects/jmeter_influxdb_configmap.yaml

kubectl delete  -f k8s_objects/jmeter_influxdb_deploy.yaml

kubectl delete  -f k8s_objects/jmeter_influxdb_svc.yaml

echo "Creating Grafana Deployment"

kubectl delete  -f k8s_objects/jmeter_grafana_deploy.yaml

kubectl delete  -f k8s_objects/jmeter_grafana_svc.yaml
