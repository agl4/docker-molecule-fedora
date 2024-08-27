FROM fedora:42
ENV container docker

# Setting up systemd
# https://hub.docker.com/r/fedora/systemd-systemd/dockerfile

# hadolint ignore=DL3041
RUN dnf -y update && dnf clean all && dnf -y install \
    findutils \
    systemd \
    sudo \
    python3 \
    && dnf clean all

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN find /lib/systemd/system/sysinit.target.wants/ -type l | grep -v systemd-tmpfiles-setup | xargs rm -f

RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
