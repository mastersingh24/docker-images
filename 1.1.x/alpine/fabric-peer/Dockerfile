FROM golang:1.10-alpine as builder

ENV FABRIC_VER v1.1.0
RUN apk add --no-cache \
	curl \
	make \
	gcc \
	musl-dev \
	git \
	libtool;
ADD build.sh .
RUN ./build.sh

FROM alpine:3.7

RUN apk add --no-cache libtool
ENV FABRIC_CFG_PATH /etc/hyperledger/fabric
VOLUME /etc/hyperledger/fabric
VOLUME /var/hyperledger
COPY --from=builder /go/bin /usr/local/bin
COPY --from=builder /go/src/github.com/hyperledger/fabric/sampleconfig $FABRIC_CFG_PATH

