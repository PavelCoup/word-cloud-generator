FROM debian AS wcg
ARG NEXUS_CREDS
ARG BUILD_NUMBER
RUN apt-get update && apt-get install -y curl
RUN cd /tmp && curl -O -u ${NEXUS_CREDS} -X GET http://nexus:8081/repository/word-cloud-generator/1/word-cloud-generator/1.${BUILD_NUMBER}/word-cloud-generator-1.${BUILD_NUMBER}.gz
RUN cd /tmp && gunzip word-cloud-generator-1.${BUILD_NUMBER}.gz

FROM alpine:latest
ARG BUILD_NUMBER
COPY --from=wcg /tmp/word-cloud-generator-1.${BUILD_NUMBER} /word-cloud-generator
RUN chmod +x /word-cloud-generator
ENTRYPOINT nohup /word-cloud-generator
