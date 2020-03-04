FROM golang:latest
RUN apt-get update && apt-get install -y openjdk-11-jdk
RUN apt-get install -y apt-transport-https ca-certificates gnupg2 software-properties-common \
&& curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
&& add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/debian \
$(lsb_release -cs) \
stable" \
&& apt-get update \
&& apt-get install -y docker-ce docker-ce-cli containerd.io
RUN apt-get install -y jq
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
