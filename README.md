# devcontainer-atgo-go

This is the devcontainer environment for using [atgo](https://github.com/meian/atgo).  
atgo is a tool for playing AtCoder by Go language.

- [日本語](README-ja.md)

## Advantages of Using a Container Environment

AtCoder provides the Go language environment in version 1.20.6, but the latest version of Go language is 1.22 or later.  
Since the Go language is backward compatible, code written in 1.20 will in principle work in 1.22 or later as long as the version is specified in go.mod.  
However, it is not guaranteed that the behavior will be the same, so even if the code is executed correctly in a local test, it may cause a WA on AtCoder due to a different behavior.  
To solve this problem, it is necessary to prepare 1.20.6 go in the local environment, but the container environment can easily supply it.

## Pre-requisite environment

- Environment to launch containers such as Docker
- [Visual Studio Code](https://code.visualstudio.com/) and [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
 
## Installation

Run the following command on the root directory of the workspace where you will be working with AtCoder using `atgo`.

```bash
$ git clone https://github.com/meian/devcontainer-atgo-go .devcontainer
```

Then open it on vscode as devcontainer on vscode using the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

## Usage

### Running `atgo`

`atgo` is installed when the container is started, so you can use it with vscode in devcontainer.

```bash
# Authenticate
$ atgo auth

# Display contest info.
$ atgo contest abc123

# Create task implements files in your workspace
$ atgo task local-init abc123_a
````

Subcommand completion with `bash-completion` is also available.  
(Only standard provided by [cobra](https://github.com/spf13/cobra))

### Updating `atgo`

When the latest version of `atgo` is released, you can update it with the following command.

```bash
# update script
# If the latest version is released locally, nothing will be processed
$ update-atgo

# Force re-installation of the latest version locally
# (not sure if there is a needs or not)
$ update-atgo -f
```

## vscode extensions

### Default installed extensions

The following extensions are automatically installed when devcontainer is started.

- [Go](https://marketplace.visualstudio.com/items?itemName=golang.Go)
- [Japanese Language Pack](https://marketplace.visualstudio.com/items?itemName=ms-ceintl.vscode-language-pack-ja)

### Additional extensions

Basically, any extensions can be installed, but the following extensions can be installed using the provided script.

- [Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [Go Autotest](https://marketplace.visualstudio.com/items?itemName=windmilleng.vscode-go-autotest)

```bash
# List supported extensions
$ add-vsc-extension 
all extensions list:
(installed) github.copilot
            windmilleng.vscode-go-autotest

# Install extension (IDs can be TAB-completed)
$ add-vsc-extension windmilleng.vscode-go-autotest
Extension 'windmilleng.vscode-go-autotest' is installed...
The extension 'windmilleng.vscode-go-autotest' v1.6.0 has been successfully installed.
```

## License

This tool is licensed under the MIT License.
