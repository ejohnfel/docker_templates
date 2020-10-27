FROM ubuntu

LABEL maintainer="me@who.com"

# Set proxy up so we can install and patch
#COPY proxy.conf /etc/apt/apt.conf.d/proxy.conf

#ENV HTTP_PROXY proxy.noc.stonybrook.edu:8080/
#ENV HTTPS_PROXY proxy.noc.stonybrook.edu:8080/

# RUNCMD - If using startup.sh and you wish to run something other then the repeatable loop, use this flag to define what to run
#ENV RUNCMD "/usr/local/bin/something"

#EXPOSE 80/TCP
#EXPOSE 443/TCP

# HTTPD examples taken from httpd container repository page
#COPY my-httpd.conf /usr/local/apache2/conf/httpd.conf

# SSL Key Examples
#COPY ssl_cert.cer /usr/local/apache2/conf/server.crt
#COPY ssl_cert.key /usr/lcoal/apache2/conf/server.key

# If TZ is needed or some install procedures ask for dialogs
#ARG DEBIAN_FRONTEND=noninteractive
#ENV TZ=America/New_York

# Basic Install
RUN apt-get update && \
apt-get -y install screen build-essential git sudo

# For PS
# RUN apt-get -y install procps

# User and Groups
RUN groupadd --gid 1499 storage && \
groupadd --gid 1500 ejohnfelt && \
useradd -M --uid 1500 --gid 1500 ejohnfelt -G storage,staff -s /usr/sbin/nologin

# Setup Startup
COPY startup.sh /usr/local/bin/
RUN chmod +rx /usr/local/bin/startup.sh

# Example developer supplied entry point code
ENTRYPOINT ["/usr/local/bin/startup.sh"]
