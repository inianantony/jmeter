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

Add Jmeter's bin directory to the PATH

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

## Execution order of the components

The execution happens in hierarchical and ordered.

Hierarchical -> some component has higher priority over other components so they will be executed first even though they ore ordered below some other component.

Ordered -> the execution happen in the same way its ordered in the test plan

``` list

Test Plan
|
|-- Thread Group
    |
    |-- Home
    |
    |-- Transaction Controller
        |
        |-- Book Catalog
        |
        |-- Book Detail
    |
    |-- Login

```

In the above example for `Ordered` Test Plan the order of execution will be from

Home --> Book Catalog --> Book Detail --> Login

``` list

Test Plan
|
|-- Thread Group
    |
    |-- Home
    |
    |-- Response Assertion 1
    |
    |-- Transaction Controller
        |
        |-- Book Catalog
        |
        |-- Book Detail
        |
        |-- Response Assertion 2

```

In the above example for `Hierarchical` Test Plan, response assertion 1 apply to home request and response assertion 2 apply to book catalog and book detail request. So the order of execution will be from

Home --> response assertion 1
Catalog --> response assertion 2
book detail --> response assertion 2

### Execution order

Configuration Elements --> Pre Processors --> Timers --> Logic Controllers / Samplers --> Post processors --> Assertions --> Listeners

The post processors, assertions, and listeners will execute only if there is response from the samplers. Similarly timers, pre and post processors are only executed if there is samplers for which they can be applied to.

User defined variables will be executed first no matter where its placed. Configuration manager element placed in the nested child node will override the same setting from the parent. Thus configuration default elements are merged while managers are not.

``` list

Test Plan
|
|-- Thread Group
    |
    |-- Transaction Controller 1
        |
        |-- Http Request default 1
        |
        |-- Home
    |-- Transaction Controller 2
        |
        |-- Login
        |
        |-- User defined variables
    |
    |-- Http Request default 3

```

So the scope will be

1. User defined variables ( and it applies to both Transaction controller 1 & 2)
2. Http Request Default 1 ( applies to Transaction controller 1)
3. Http Request Default 2 ( and it applies to both Transaction controller 1 & 2)

### Examples

![Sample1](https://github.com/inianantony/jmeter/blob/master/images/sample1.png?raw=true)

The execution order will be Uniform random timer -> COnstant timer -> Home -> Response Assertion -> View results tree

![Sample2](https://github.com/inianantony/jmeter/blob/master/images/sample2.png?raw=true)

The execution order will be

Timer -> Home Request -> Post processor 1 -> Post processor 2
Catalog Request -> Post Processor 1 -> Post Processor 3 -> Assertion -> View Results Tree

![Sample3](https://github.com/inianantony/jmeter/blob/master/images/sample3.png?raw=true)

The execution order will be

Timer 1 -> Timer 2 -> Home Request -> Timer 1 -> Timer 2 -> Catalog Request

![Sample4](https://github.com/inianantony/jmeter/blob/master/images/sample4.png?raw=true)

The execution order will be

Home Request -> Think Time 1 -> Catalog Request -> Think Time 2

So a think timer executes after a request while the normal timer executes before the request.

## Creating the test script

### Steps

1. Rename the default test plan to Performance Test Plan
2. Add `Http Request Defaults` -> Configuration Defaults
3. Add server name or ip as `localhost` and port as `8080`
4. Add `Thread Group` and rename it as User Thread Group
5. Add `Transaction Controller` and `check` the Generate parent sample
6. Add `Http Request` under Transaction Controller and rename as Home Request and set the `path` to be `/`
7. Ad another `Http Request` under Transaction Controller and rename as Book Catalog Request and set the `path` to be `/books`
8. Add `Response Assertion` under Transaction Controller and click `Response Code` as the Field to test, and click `Add` to add a pattern to test and set `200` as the pattern
9. Under User Thread Group add another `Http Request` and rename as Book Detail Request and set the `path` to be `/books/1`
10. Add a `Uniform Random Timer` under User Thread Group and set the random delay to be `7000` milliseconds
11. Add 2 Listeners , `View Results Tree` and `Summary Report` under User Thread group 
12. Now save the script as `PerformanceTestPlan.jmx`

## Running the app

from the root of the project run the command

``` bash
docker build -f ./dockerfiles/app.Dockerfile -t app:v1 .

docker run app:v1 -p 8080:8080

```

Now the app will run and the host port 8080 is bound to the app.

## Running the test

``` bash
jmeter -n -t PerformanceTestPlan.jmx -l results.csv -j logfile.log -e -o ./jmeterout
```
