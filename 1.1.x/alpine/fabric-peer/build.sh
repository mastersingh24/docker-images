#!/bin/sh

FABRIC_VER=1.1.0
BASE_VER=0.4.6

GO_TAGS=experimental

GO_LDFLAGS="-X github.com/hyperledger/fabric/common/metadata.Version=${FABRIC_VER} \
	-X github.com/hyperledger/fabric/common/metadata.BaseVersion=${FABRIC_VER} \
	-X github.com/hyperledger/fabric/common/metadata.BaseDockerLabel=org.hyperledger.fabric \
	-X github.com/hyperledger/fabric/common/metadata.DockerNamespace=ibmblockchain \
	-X github.com/hyperledger/fabric/common/metadata.BaseDockerNamespace=ibmblockchain \
	-X github.com/hyperledger/fabric/common/metadata.Experimental=true"

mkdir -p $GOPATH/src/github.com/hyperledger
cd $GOPATH/src/github.com/hyperledger
git clone https://github.com/hyperledger/fabric.git
cd fabric
git checkout v${FABRIC_VER}
go install -tags "${GO_TAGS}" -ldflags "${GO_LDFLAGS}" github.com/hyperledger/fabric/peer
cd ..
git clone https://github.com/hyperledger/fabric-ca.git
cd fabric-ca
git checkout v${FABRIC_VER}
GO_LDFLAGS="-X github.com/hyperledger/fabric-ca/lib/metadata.Version=${FABRIC_VER}"
go install -ldflags "${GO_LDFLAGS}" github.com/hyperledger/fabric-ca/cmd/fabric-ca-client