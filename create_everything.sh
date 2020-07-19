#!/bin/bash -e

chmod +x ./create_images.sh ./create_cluster.sh ./create_environment.sh ./create_test.sh

./create_images.sh

./create_cluster.sh

sleep 20

kubectl get pods

./create_environment.sh

./create_test.sh
