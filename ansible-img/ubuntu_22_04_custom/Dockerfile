FROM ubuntu:22.04

RUN apt-get update || true

RUN apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:toor' | chpasswd

COPY ssh_key /root/.ssh/

RUN chmod 644 /root/.ssh/id_rsa.pub && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod 600 /root/.ssh/authorized_keys

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
