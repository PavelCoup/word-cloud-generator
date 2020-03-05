FROM debian AS wcg
ARG NEXUS_CURL
ARG BUILD_NUMBER
RUN apt-get update && apt-get install -y curl
RUN cd /tmp && ${NEXUS_CURL} \
&& gunzip word-cloud-generator-1.${BUILD_NUMBER}.gz

FROM alpine:latest
COPY --from=wcg /tmp/word-cloud-generator /
RUN chmod +x /word-cloud-generator
ENTRYPOINT nohup /word-cloud-generator
