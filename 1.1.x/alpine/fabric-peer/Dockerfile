FROM golang:1.9.2-alpine3.7 as builder

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

RUN apk add --no-cache libltdl
ENV FABRIC_CFG_PATH /etc/hyperledger/fabric
VOLUME /etc/hyperledger/fabric
VOLUME /var/hyperledger
COPY --from=builder /go/bin /usr/local/bin
COPY --from=builder /go/src/github.com/hyperledger/fabric/sampleconfig $FABRIC_CFG_PATH

