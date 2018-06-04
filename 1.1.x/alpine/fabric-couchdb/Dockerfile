From alpine:3.6 as builder

ENV COUCHDB_VER 2.1.1
RUN set -x \
	&& apk update \
	&& apk --no-cache add \
	   ca-certificates \
	   sudo \
	   curl \
	   gnupg \
	   tar \
	   gzip \
	   zip \
	   bash \
	   make \
	   gcc \
	   g++ \
	   perl \
	   python \
	   autoconf \
	   m4

# Mozilla SpiderMoney 1.8.5
RUN mkdir /tmp/js-1.8.5 \
	&& cd /tmp \
	&& curl http://ftp.mozilla.org/pub/js/js185-1.0.0.tar.gz --output js185-1.0.0.tar.gz \
    && tar zxf js185-1.0.0.tar.gz -C /tmp/js-1.8.5 --strip-components=1 \
    && cd /tmp/js-1.8.5/js/src \
	&& CXXFLAGS="--std=gnu++98" ./configure --prefix=/usr \
	&& make \
	&& make install

# CouchDB
RUN apk --no-cache add \
	erlang \
	erlang-asn1 \
	erlang-crypto \
	erlang-erts \
	erlang-inets \
	erlang-os-mon \
	erlang-public-key \
	erlang-runtime-tools \
	erlang-sasl \
	erlang-ssl \
	erlang-syntax-tools \
	erlang-xmerl \
	icu-libs \
	build-base \
	curl-dev \
	erlang-dev \
	erlang-eunit \
	erlang-reltool \
	erlang-syntax-tools \
	erlang-tools \
	icu-dev

RUN mkdir /tmp/couchdb \
	&& cd /tmp \
	&& curl -sSL https://archive.apache.org/dist/couchdb/source/${COUCHDB_VER}/apache-couchdb-${COUCHDB_VER}.tar.gz --output couchdb.tar.gz \
	&& tar zxf couchdb.tar.gz -C /tmp/couchdb --strip-components=1 \
	&& cd /tmp/couchdb \
	&& ./configure --disable-docs \
	&& make release


FROM alpine:3.6

RUN apk --no-cache add \
        bash \
        curl \
        erlang \
        erlang-asn1 \
        erlang-crypto \
        erlang-erts \
        erlang-inets \
        erlang-os-mon \
        erlang-public-key \
        erlang-runtime-tools \
        erlang-sasl \
        erlang-ssl \
        erlang-syntax-tools \
        erlang-xmerl \
        help2man \
        icu-libs \
        pwgen \
        tini
COPY --from=builder /usr/lib/libmozjs185.so.1.0.0 /usr/lib/libmozjs185.so.1.0.0
RUN ln -s /usr/lib/libmozjs185.so.1.0.0 /usr/lib/libmozjs185.so.1.0 \
	&& ln -s /usr/lib/libmozjs185.so.1.0 /usr/lib/libmozjs185.so \
	&& mkdir -p /opt/couchdb \
	&& mkdir /opt/couchdb/data
COPY --from=builder /tmp/couchdb/rel/couchdb /opt/couchdb

WORKDIR /opt/couchdb