FROM ubuntu:22.04

# Install dependencies
RUN apt-get update || true

RUN ln -snf /usr/share/zoneinfo/Europe/Paris /etc/localtime && echo Europe/Paris > /etc/timezone

RUN DEBIAN_FRONTEND=noninteractive apt install -y \
        software-properties-common \
        python-setuptools \
        python3-pip \
    && apt clean \
   && rm -rf /var/lib/apt/lists/*

RUN apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible openssh-client

RUN apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/*

# SSH configuration and root user setup
RUN mkdir /var/run/sshd \
    && mkdir /root/.ssh \
    && chmod 700 /root/.ssh \
    && sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo 'root:toor' | chpasswd \
    && chown -R root:root /root/.ssh

# SSH key setup
COPY ssh_key /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa

# Expose SSH port
EXPOSE 22
#EXPOSE 80

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]
