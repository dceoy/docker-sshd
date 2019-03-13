FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests ssh \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && mkdir -p /var/run/sshd /etc/ssh/authorized_keys \
      && chmod 755 /etc/ssh/authorized_keys \
      && sed -i \
        -e 's/^#\(PubkeyAuthentication\s\+\).*$/\1yes/' \
        -e 's/^#\(PasswordAuthentication\s\+\).*$/\1no/' \
        -e 's/^#\(AuthorizedKeysFile\s\+\).*$/\1\/etc\/ssh\/authorized_keys\/%u/' \
        /etc/ssh/sshd_config
#     && ln -sf /dev/stdout /var/log/auth.log

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]
