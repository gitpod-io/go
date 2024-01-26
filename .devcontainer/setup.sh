# install curl, git, ...
apt-get update
apt-get install -y curl git jq

useradd -m user
su user

# install go
VERSION='1.21.6'
OS='linux'

ARCH=""
case $(uname -m) in
    i386)   ARCH="386" ;;
    i686)   ARCH="386" ;;
    x86_64) ARCH="amd64" ;;
    arm)    dpkg --print-architecture | grep -q "arm64" && ARCH="arm64" || ARCH="arm" ;;
esac

curl -fsSL https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz | tar xzs -C /usr/local

INSTALLED_GO_VERSION=$(go version)
echo "Go version ${INSTALLED_GO_VERSION} is installed"

# vscode-go dependencies 
echo "Getting dependencies for the vscode-go plugin"
go install -v github.com/uudashr/gopkgs/cmd/gopkgs@v2 \
    && go install -v github.com/ramya-rao-a/go-outline@latest \
    && go install -v github.com/cweill/gotests/gotests@latest \
    && go install -v github.com/fatih/gomodifytags@latest \
    && go install -v github.com/josharian/impl@latest \
    && go install -v github.com/haya14busa/goplay/cmd/goplay@latest \
    && go install -v github.com/go-delve/delve/cmd/dlv@latest \
    && go install -v github.com/golangci/golangci-lint/cmd/golangci-lint@latest \
    && go install -v golang.org/x/tools/gopls@latest \
    && go install -v honnef.co/go/tools/cmd/staticcheck@latest \
    && go install -v github.com/rakyll/hey@latest
