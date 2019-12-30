FROM fedora:31
RUN dnf update -y
RUN adduser runner
RUN usermod -aG wheel runner
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER runner
WORKDIR /home/runner/setup
ENTRYPOINT [ "/bin/bash" ]