FROM ubuntu:20.04
ENV PATH "$PATH:/usr/local/go/bin"
RUN DEBIAN_FRONTEND=noninteractive apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y build-essential make wget tar python3 dos2unix python3-venv
RUN mkdir -p /usr/local && \
    wget -q https://golang.org/dl/go1.14.7.linux-amd64.tar.gz && \
    tar -xzf go1.14.7.linux-amd64.tar.gz -C /usr/local
RUN wget https://github.com/ktr0731/evans/releases/download/0.9.1/evans_linux_amd64.tar.gz && \
    tar -xzf evans_linux_amd64.tar.gz -C /usr/local/bin
CMD echo "starting ubuntu proxy container"
