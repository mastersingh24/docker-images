FROM golang:1.9.2-alpine3.7 as builder

ENV FABRIC_VER 1.1.0
ENV GO_LDFLAGS "-X github.com/hyperledger/fabric-ca/lib/metadata.Version=${FABRIC_VER}"
RUN apk add --no-cache \
	curl \
	make \
	gcc \
	musl-dev \
	git \
	libtool \
	&& mkdir -p $GOPATH/src/github.com/hyperledger \
	&& cd $GOPATH/src/github.com/hyperledger \
	&& git clone https://github.com/hyperledger/fabric-ca.git \
	&& cd fabric-ca \
	&& git checkout v${FABRIC_VER} \
	&& go install -ldflags "${GO_LDFLAGS}" github.com/hyperledger/fabric-ca/cmd/fabric-ca-client

FROM alpine:3.7
RUN apk add --no-cache libltdl
COPY --from=builder /go/bin/fabric-ca-client /usr/bin/