#!/bin/bash -e

jmx="./PerformanceTestPlan.jmx"

test_name="$(basename "$jmx")"

echo "Get Master pod details and copy the test script inside"

master_pod=`kubectl get pods | grep jmeter-master | awk '{print $1}'`

echo "jmx : $jmx and test_name: $test_name and masterpod: $master_pod"

kubectl cp ./PerformanceTestPlan.jmx "$master_pod:/$test_name"

echo "Starting Jmeter load test"

kubectl exec -ti $master_pod -- /bin/bash /load_test "$test_name"