FROM openjdk:8-jdk-slim
LABEL maintainer "Antony"
				
RUN apt-get clean && \
apt-get update && \
apt-get -qy install \
wget \
telnet \
iputils-ping \
unzip

RUN   mkdir /jmeter \
&& cd /jmeter/ 

WORKDIR /jmeter

COPY ./apache-jmeter-5.0.tgz /jmeter

RUN tar -xzf apache-jmeter-5.0.tgz \
&& rm apache-jmeter-5.0.tgz

ENV JMETER_HOME /jmeter/apache-jmeter-5.0/

WORKDIR /
	
ENV PATH $JMETER_HOME/bin:$PATH