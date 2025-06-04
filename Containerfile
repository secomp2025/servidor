FROM lscr.io/linuxserver/code-server:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python-is-python3 \
        python3 \
        python3-pip \
        nodejs \
        npm && \
    rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/bash

env SERVICE_URL=https://extensions.coder.com/api 
env ITEM_URL=https://extensions.coder.com/item

EXPOSE 8443
EXPOSE 5000-5100

# RUN /app/code-server/bin/code-server --install-extension ms-python.python && \
#     #/app/code-server/bin/code-server --install-extension ms-python.vscode-pylance && \
#     /app/code-server/bin/code-server --install-extension formulahendry.code-runner