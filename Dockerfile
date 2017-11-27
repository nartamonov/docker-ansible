# Основан на популярном образе William-Yeh/docker-ansible
# (см. https://github.com/William-Yeh/docker-ansible/blob/master/debian9/Dockerfile)
# От оригинального образа отличается фиксированными версиями базового дистрибутива и
# Ansible, настроенной локалью C.UTF-8, и отключенной проверкой ключей хостов SSH.

FROM debian:9.2

LABEL maintainer "Nikolay Artamonov <nartamonov@gmail.com>"

ENV LANG C.UTF-8

ENV ANSIBLE_VERSION 2.4.1.0

RUN echo "===> Installing python, sudo, and supporting tools..."  && \
    apt-get update -y  &&  apt-get install --fix-missing          && \
    DEBIAN_FRONTEND=noninteractive         \
    apt-get install -y                     \
        python python-yaml sudo            \
        curl gcc python-pip python-dev libffi-dev libssl-dev  && \
    apt-get -y --purge remove python-cffi          && \
    pip install --upgrade cffi pywinrm             && \
    \
    \
    echo "===> Installing Ansible..."       && \
    pip install ansible==${ANSIBLE_VERSION} && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apt-get install -y sshpass openssh-client  && \
    \
    \
    echo "===> Removing unused APT resources..."                  && \
    apt-get -f -y --auto-remove remove \
                 gcc python-pip python-dev libffi-dev libssl-dev  && \
    apt-get clean                                                 && \
    rm -rf /var/lib/apt/lists/*  /tmp/*                           && \
    \
    \
    echo "===> Adding hosts for convenience..."        && \
    mkdir -p /etc/ansible                              && \
    echo 'localhost' > /etc/ansible/hosts

RUN echo "==> Disable SSH host key checking for convenience..."      && \
    mkdir /root/.ssh                                                 && \
    echo "Host *\n\tStrictHostKeyChecking no\n\n" > /root/.ssh/config

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
