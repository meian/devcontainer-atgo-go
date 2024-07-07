#!/bin/bash

user=$1

sudo mkdir -p /go/pkg
sudo chown -R "$user:golang" /go/pkg
sudo mkdir -p "/home/$user/.cache/go-build"
sudo chown "$user:$user" "/home/$user/.cache/go-build"

source ~/.profile

atgo completion bash | sudo tee /etc/bash_completion.d/atgo > /dev/null

LSCRIPT="$(cd "$(dirname "$0")"; pwd)/postCommand.local.sh"
if [ -x "$LSCRIPT" ]; then
    "$LSCRIPT" "$u"
fi

atgo version --long
