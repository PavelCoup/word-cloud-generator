FROM golang:latest
RUN apt-get update && apt-get install -y jq openjdk-11-jdk apt-transport-https ca-certificates gnupg2 software-properties-common \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
&& add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io
# ENV GOPATH /workspace/final-pipeline
# ENV PATH /go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/workspace/final-pipeline/bin
RUN go get -u golang.org/x/lint/golint
RUN go get github.com/GeertJohan/go.rice/rice
RUN go get -u github.com/tools/godep
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
