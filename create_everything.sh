#!/bin/bash -e

chmod +x ./create_images.sh ./create_cluster.sh ./create_environment.sh ./create_test.sh

./create_images.sh

./create_cluster.sh

sleep 20

kubectl get pods

./create_environment.sh

./create_test.sh


grafana_pod=`kubectl get pods | grep jmeter-grafana | awk '{print $1}'`

kubectl port-forward $grafana_pod 3001:3000