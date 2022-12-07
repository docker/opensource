FROM alpine

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN apk add --no-cache ca-certificates

COPY . /go/src/github.com/docker/opensource

ENV GO111MODULE=off

RUN buildDeps=' \
		go \
		git \
		gcc \
		libc-dev \
		libgcc \
	' \
	set -x \
	&& apk update \
	&& apk add $buildDeps \
	&& cd /go/src/github.com/docker/opensource \
	&& go get github.com/BurntSushi/toml \
	&& go get github.com/sirupsen/logrus \
	&& go generate ./maintainercollector \
	&& go build -o /usr/bin/maintainercollector ./maintainercollector \
	&& apk del $buildDeps \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /go \
	&& echo "Build complete."

WORKDIR /root/maintainers

ENTRYPOINT [ "maintainercollector" ]
