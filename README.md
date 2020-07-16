# Performance Testing

## Response Time

Time taken for request to reach server + Server processing time + Time for response to return to client. The more the better

## Throughput

``` formula

Number of transactions ( request / response)
--------------------------------------------
     Unit of Time (milliseconds/seconds)

```

OR

``` formula

Number of (K)bytes ( sent / received)
-------------------------------------
 Unit of Time (milliseconds/seconds)

```

the more the better

## Reliability

``` formula

 Number of errors
------------------
Number of requests

```

the less the better

## Scalability

How well a system scales in terms of Response time , Throughput, and Reliability when additional resources are added.

## Performance requirements

The performance testing should be done against a list of performance requirements given in SLA documents. Some example like

The average / max response time should be ____
The system should be able to support____ pages per second
The system should be capable of supporting at least____ users per hour

## Types of Performance test load

1. Number of users
2. Number of request

## Types of performance test

1. Peak Load test
2. Stress test
3. Spike test
4. Endurance test

## Download and install Jmeter

<http://jmeter.apache.org/download_jmeter.cgi>

## Running Jmeter

``` bash
> jmeter \
    -n \ # run in non graphical mode
    -t \ # to specify the file name
    testfile.jmx \ # file name containing the test script
    -l \ # specify the results file
    results.csv \ # result file name
    -j \ # specify the log file
    logfile.log \ # file name of lof file
    -e \ # specify to generate a html report
    -o # specify the output folder
```

## Plugins

Download ang jmeter plugin you want and install to `/lib/ext` directory and restart jmeter.

Plugins worth installing

1. Custom thread groups
2. 3 basic graphs
3. THroughput shaping timer
4. Dummy sampler

## Components of Test

### Test Plan

Its the root of the test and all other components are under it.

### Thread groups

Its the entry point of the test. It controls the number of threads( users) used to execute the test. We can add multiple thread group to a test plan and it acts like individual test case.

### Config Elements

Allow us to define configuration values to be used in the test.

### Controllers

Logic controllers customize the logic of when to sent the request

### Samplers

Samplers make the request to the server.

### Timers

Timers introduce delay between the request to simulate real world scenario.

### Assertions

Validate the response as expected is sent from server.

### Listeners

Jmeter collects information about the request it performs and listeners aggregate and show metrics from that information by listening to it.

