#!/bin/bash

u=$1

sudo mkdir -p /go/pkg
sudo chown vscode:golang /go/pkg
sudo mkdir -p "/home/$u/.cache/go-build"
sudo chown vscode:vscode "/home/$u/.cache/go-build"

mkdir -p /etc/bash_completion.d
atgo completion bash | sudo tee /etc/bash_completion.d/atgo | cat > /dev/null

LSCRIPT="$(cd "$(dirname "$0")"; pwd)/postCommand.local.sh"
if [ -x "$LSCRIPT" ]; then
    "$LSCRIPT" "$u"
fi
