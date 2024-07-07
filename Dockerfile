FROM golang:1.22.4-bookworm AS env-builder

RUN go install github.com/posener/complete/gocomplete@latest \
    && go install golang.org/x/tools/gopls@v0.16.1 \
    && go install github.com/cweill/gotests/gotests@v1.6.0 \
    && go install github.com/go-delve/delve/cmd/dlv@v1.22.1

FROM golang:1.20.6-bookworm as atcoder

ARG USERNAME=vscode

RUN apt-get update \
    && apt-get install -y \
    bash-completion=1:2.* \
    curl=7.* \
    sqlite3=3.* \
    sudo=1.9.* \
    vim=2:9.* \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/ \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && mkdir -p /etc/bash_completion.d \
    && groupadd -g 999 golang \
    && curl -fL https://raw.githubusercontent.com/devcontainers/features/feature_go_1.2.2/src/common-utils/scripts/bash_theme_snippet.sh -o /etc/bash_prompt.sh \
    && chmod +x /etc/bash_prompt.sh
RUN grep -E "^$USERNAME:" /etc/group || groupadd $USERNAME -g 1000
RUN useradd -m -g $USERNAME -u 1000 -s /bin/bash -G golang $USERNAME \
    && chown -R $USERNAME:golang /go \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME

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
    && echo 'source /etc/bash_prompt.sh' >> "$HOME/.bashrc" \
    && echo 'source add-vsc-extension --complete' >> "$HOME/.bashrc"
