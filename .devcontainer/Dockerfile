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

# Install the gopls Go Language Server, see https://github.com/golang/tools/tree/master/gopls
RUN go install golang.org/x/tools/gopls@latest

# Install Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target add wasm32-wasi

COPY dream /bin
COPY tau /bin
