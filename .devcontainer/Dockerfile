FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    bash                                 \
    git                                  \
    curl                                 \
    nodejs                               \
    npm                                  \
    golang-go                            \
    build-essential libssl-dev pkg-config\
    glibc-source                         \
    ca-certificates

RUN asudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Install the gopls Go Language Server, see https://github.com/golang/tools/tree/master/gopls
RUN go install golang.org/x/tools/gopls@latest

# Install Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target add wasm32-wasi

# install Taubyte tools
COPY tau dream spore-drive /bin/

RUN echo 'eval "`tau autocomplete`"' >> /root/.bashrc

RUN mkdir -p /root/.taubyte/networks/

COPY  testnet /root/.taubyte/networks/testnet

RUN /bin/spore-drive genkey swarm -o /root/.taubyte/networks/testnet/keys/swarm.key
RUN /bin/spore-drive genkey domain --dir /root/.taubyte/networks/testnet/keys  --priv --pub