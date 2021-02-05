FROM registry.access.redhat.com/ubi8/ubi-init:latest

LABEL maintainer="luigizuccarelli@gmail.com"

# gcc for cgo
RUN dnf install -y git gcc make && rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.15.6
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 3918e6cc85e7eaaa6f859f1bdbaac772e7a825b0eb423c63d3ae68b21f84b844

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV PATH $PATH:/bin:/usr/local/go/bin:/usr/bin/

RUN mkdir -p /go/src /go/bin /go/build && chmod -R 0777 /go
COPY uid_entrypoint.sh /go/ 
RUN chown 1001:root /go

WORKDIR /go

USER 1001

ENTRYPOINT [ "./uid_entrypoint.sh" ]
