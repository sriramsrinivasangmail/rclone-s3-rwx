FROM registry.access.redhat.com/ubi8-minimal:latest

COPY ./scripts /scripts
RUN ./scripts/imagesetup.sh

USER 1001
ENTRYPOINT ["/scripts/startup.sh"]
