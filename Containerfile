FROM registry.redhat.io/redhat-openjdk-18/openjdk18-openshift:latest
LABEL "io.openshift.s2i.build.image"="registry.redhat.io/redhat-openjdk-18/openjdk18-openshift:latest" \
      "io.openshift.s2i.build.source-location"="undertow-servlet/"

USER root
# Copying in source code
COPY upload/src /tmp/src
# Change file ownership to the assemble user. Builder image must support chown command.
RUN chown -R 1001:0 /tmp/src
USER 1001
# Assemble script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
RUN /usr/libexec/s2i/assemble
# Run script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
CMD /usr/libexec/s2i/run
