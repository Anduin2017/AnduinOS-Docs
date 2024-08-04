# Golang

Go is a statically typed, compiled high-level programming language designed at Google by Robert Griesemer, Rob Pike, and Ken Thompson.

To Install Golang on AnduinOS, first download a tar.gz package form [here](https://go.dev/dl). Then you need to extract the tar.gz file into `/usr/local`:

<!-- The link needs to be updated regularly. -->

```bash
wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
rm go1.22.5.linux-amd64.tar.gz
```

!!! warning "The link above may be outdated"

    The link above may be outdated. Please visit the [official website](https://go.dev/dl/) to get the latest version.

After extract the binary file, add some environment variables into `$HOME/.bashrc`

```bash
export GOROOT=/usr/local/go
export GOPATH=$HOME/.golang
export PATH=$GOROOT/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export GO111MODULE=on
# optional
# export GOPROXY=https://goproxy.cn
```
