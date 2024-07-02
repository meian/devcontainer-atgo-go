FROM golang:1.22.4-bookworm AS env-builder

RUN go install github.com/posener/complete/gocomplete@latest \
    && go install golang.org/x/tools/gopls@v0.16.1 \
    && go install github.com/cweill/gotests/gotests@v1.6.0 \
    && go install github.com/go-delve/delve/cmd/dlv@v1.22.1

FROM mcr.microsoft.com/devcontainers/go:1.20-bookworm as atcoder

ARG USERNAME=vscode

RUN apt-get update \
    && apt-get install -y \
    bash-completion=1:2.* \
    curl=7.* \
    sqlite3=3.* \
    vim=2:9.* \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/ \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY --from=env-builder /go/bin /go/bin

COPY --chown=${USERNAME}:${USERNAME} ./resources/update-atgo /usr/local/bin/update-atgo
RUN chmod +x /usr/local/bin/update-atgo

USER ${USERNAME}

RUN mkdir -p /home/${USERNAME}/.local/bin
COPY --chown=${USERNAME}:${USERNAME} ./resources/add-vsc-extension /home/${USERNAME}/.local/bin/add-vsc-extension
RUN chmod +x /home/${USERNAME}/.local/bin/add-vsc-extension
COPY --chown=${USERNAME}:${USERNAME} ./resources/vsc-extensions.list /home/${USERNAME}/.local/bin/vsc-extensions.list

RUN gocomplete -install -y \
    && update-atgo \
    && ll > /dev/null || echo 'alias ll="ls -alF"' >> "$HOME/.bashrc" \
    && echo 'source add-vsc-extension --complete' >> "$HOME/.bashrc"
