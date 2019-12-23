#!/usr/bin/env bash
cd /usr/local
wget -O go.tar.gz https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
tar -zxf go.tar.gz
rm go.tar.gz

export GOROOT=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

OLDPATH="$PATH"
#PATH="$PATH:/usr/local/go/bin"

go get -u -v github.com/catding/shadowsocks-multiuser
cd ~/go/src/github.com/catding/shadowsocks-multiuser

go build -ldflags "-w -s"

mkdir -p /opt/shadowsocks-multiuser
cp shadowsocks-multiuser /opt/shadowsocks-multiuser
chmod +x /opt/shadowsocks-multiuser/shadowsocks-multiuser
cp scripts/systemd/shadowsocks-multiuser.service /etc/systemd/system
systemctl daemon-reload

rm -rf ~/go

PATH="$OLDPATH"
cd /usr/local
rm -rf go

exit 0
