#!/bin/bash -e

jmx="PerformanceTestPlan.jmx"

test_name="$(basename "$jmx")"

#Get Master pod details

master_pod=`kubectl get pods | grep jmeter-master | awk '{print $1}'`

kubectl cp "$jmx" "$master_pod:/$test_name"

## Echo Starting Jmeter load test

kubectl exec -ti $master_pod -- /bin/bash /load_test "$test_name"