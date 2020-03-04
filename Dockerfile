FROM golang:latest
RUN apt-get update && apt-get install -y openjdk-11-jdk
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
ENTRYPOINT /bin/bash
