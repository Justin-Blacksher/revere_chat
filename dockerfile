# Use Alpine Linux as the base image
FROM alpine:latest

RUN apk add bash

# Git the vanity URL program

# Expose and map ports (8443:443)
EXPOSE 8443
RUN mkdir -p /etc/tor/
COPY ./torrc /etc/tor/
COPY ./torsocks.conf /etc/tor/
# Set up TOR hidden services
RUN mkdir -p /usr/local/revere/bin/
COPY ./setup.sh /usr/local/revere/bin/setup.sh
# SETUP YOUR PASSWORD HERE TO USE GPG keys
ENV PASSWORD_GPG=p@ssw0rd
# Additional steps (e.g., copying your Go server code) should be added here
ENTRYPOINT [ "/usr/local/revere/bin/setup.sh" ]

