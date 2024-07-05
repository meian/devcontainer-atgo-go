# devcontainer-atgo-go

AtCoder の Go 言語用ツールの [atgo](https://github.com/meian/atgo) をコンテナ上で vscode から利用するための devcontainer 環境です。

- [English](README.md)

## コンテナ環境を使うメリット

AtCoderではGo言語の環境はバージョン 1.20.6 で提供されていますが、現行の Go 言語の最新バージョンは 1.22 以降になっています。  
Go 言語は後方互換生が保たれているため、1.20 で書かれたコードは go.mod でバージョンを指定している限りは原則として 1.22 以降でも動作します。  
ただし確実に同じ挙動になることが保証されているわけではないので、ローカルの動作確認で正常に実行されても AtCoder 上では挙動が違うことで WA になることがあります。  
この問題を解決するためにはローカル環境に 1.20.6 の go を用意する必要がありますが、コンテナ環境を使うことでこの環境を容易に構築できます。

## 必要な環境

- Dockerなどのコンテナを起動する環境
- [Visual Studio Code](https://code.visualstudio.com/) と [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) 拡張機能

## インストール方法

`atgo` を使って AtCoder の作業を行うワークスペースのルートディレクトリ上で以下のコマンドを実行してください。

```bash
$ git clone https://github.com/meian/devcontainer-atgo-go .devcontainer
```

その後 [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) の機能を用いて vscode 上で devcontainer として開いてください。

## 使い方

### `atgo` の実行

コンテナ起動時に `atgo` がインストールされているため、devcontainer をvscodeで開いてすぐに使用できます。

```bash
# 認証情報を設定する
$ atgo auth

# コンテスト情報を表示する
$ atgo contest abc123

# ワークスペースに実装用のファイルを作成する
$ atgo task local-init abc123_a
```

また、 `bash-completion` によるサブコマンド補完が利用できます。  
([cobra](https://github.com/spf13/cobra) で提供される標準の補完機能のみ)

### `atgo` のアップデート

`atgo` の最新版がリリースされた場合、以下のコマンドでアップデートできます。

```bash
# アップデートスクリプト
# ローカルに最新版がリリースされている場合は何も処理されません
$ update-atgo

# ローカルに最新版を強制的にインストールしなおします
# (ニーズがあるかどうかはわからない)
$ update-atgo -f
```

## vscodeの拡張機能

### 標準でインストールされる拡張機能

以下の拡張機能はdevcontainerの起動時に自動的にインストールされます。

- [Go](https://marketplace.visualstudio.com/items?itemName=golang.Go)
- [Japanese Language Pack](https://marketplace.visualstudio.com/items?itemName=ms-ceintl.vscode-language-pack-ja)

### 追加でインストール可能な拡張機能

基本的にはどの拡張機能もインストール可能ですが、以下の拡張機能についてはインストール用のスクリプトを用意しているため、それを用いてインストールできます。

- [Copilot](https://marketplace.visualstudio.com/items?itemName=GitHub.copilot)
- [Go Autotest](https://marketplace.visualstudio.com/items?itemName=windmilleng.vscode-go-autotest)

```bash
# 対応している拡張機能の一覧を表示
$ add-vsc-extension 
all extensions list:
(installed) github.copilot
            windmilleng.vscode-go-autotest

# 拡張機能をインストール(IDはTAB補完可能)
$ add-vsc-extension windmilleng.vscode-go-autotest
拡張機能 'windmilleng.vscode-go-autotest' をインストールしています...
拡張機能 'windmilleng.vscode-go-autotest' v1.6.0 は正常にインストールされました。
```

## ライセンス

このツールはMITライセンスで提供されています。
