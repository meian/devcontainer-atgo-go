FROM mcr.microsoft.com/devcontainers/go:1.20-bookworm

ARG USERNAME=vscode

RUN apt-get update \
    && apt-get install -y \
    bash-completion=1:2.* \
    curl=7.* \
    sqlite3=3.* \
    vim=2:9.* \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts/ \
    && ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY --chown=${USERNAME}:${USERNAME} ./resources/update-atgo /usr/local/bin/update-atgo
RUN chmod +x /usr/local/bin/update-atgo

USER ${USERNAME}

RUN update-atgo

RUN ll > /dev/null || echo 'alias ll="ls -alF"' >> "$HOME/.bashrc"
