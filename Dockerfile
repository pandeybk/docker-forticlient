FROM ubuntu:18.04

# Install required dependencies
RUN apt-get update && apt-get install -y wget tar ppp expect openssh-client sshpass

# Download Fortigate SSLVPN CLI
RUN wget http://cdn.software-mirrors.com/forticlientsslvpn_linux_4.4.2328.tar.gz

# Extract the downloaded file
RUN tar -xzvf forticlientsslvpn_linux_4.4.2328.tar.gz

# Go to the installer setup directory
WORKDIR /forticlientsslvpn/64bit/helper

# Create an expect script to automate the setup process
RUN echo -e '#!/usr/bin/expect\nspawn ./setup.linux.sh\nexpect "Would you like to connect to this server? (Y/N)"\nsend "Y\\r"\nexpect eof' > setup.exp
RUN chmod +x setup.exp

# Go back to the root directory
WORKDIR /

# Set the entrypoint to a custom script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Default command (can be overridden by `docker run` command)
CMD ["--help"]

