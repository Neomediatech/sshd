FROM neomediatech/ubuntu-base:20.04

ENV VERSION=8.2p1-4 \
    SERVICE=sshd

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech

RUN apt-get update && apt-get -y dist-upgrade && \
    apt-get install -y --no-install-recommends \
    vim bash-completion sudo curl wget xz-utils \
    rsyslog openssh-server openssl dnsutils telnet && \
    rm -f /etc/ssh/ssh_host_* && \
    rm -rf /var/lib/apt/lists* 

COPY bin/* /
RUN chmod +x /entrypoint.sh /cmd.sh

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/tini", "--", "/cmd.sh"]
