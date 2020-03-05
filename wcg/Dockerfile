FROM debian AS wcg
ARG NEXUS_CREDS
ARG BUILD_NUMBER
RUN apt-get update && apt-get install -y curl
RUN cd /tmp && curl -O -u admin:admin -X GET http://127.0.0.1:8081/repository/word-cloud-generator/1/word-cloud-generator/1.49/word-cloud-generator-1.49.gz \
&& gunzip word-cloud-generator-1.49.gz

FROM alpine:latest
COPY --from=wcg /tmp/word-cloud-generator /
RUN chmod +x /word-cloud-generator
ENTRYPOINT nohup /word-cloud-generator
