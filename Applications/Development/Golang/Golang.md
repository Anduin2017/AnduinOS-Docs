# Golang

Go is a statically typed, compiled high-level programming language designed at Google by Robert Griesemer, Rob Pike, and Ken Thompson.

To Install Golang on AnduinOS, run the following commands:

```bash
sudo apt install golang-go
```

This will install golang 1.18 on your system. And set the following environment variables to you:

```bash
GOROOT="/usr/lib/go-1.18"
GOPATH="$HOME/go" # The HOME was set to be current user who run the installation command
GO111MODULE=""
```

Also, this package will create a symbolic at `/usr/bin/go` and `/bin/go`.

---

If you want a newest version of golang, first download a tar.gz package form [here](https://go.dev/dl). Then you need to extract the tar.gz file into `/usr/local`:

<!-- The link needs to be updated regularly. -->

```bash
wget https://go.dev/dl/go1.23.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.23.0.linux-amd64.tar.gz
rm go1.23.0.linux-amd64.tar.gz
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
