#!/bin/bash
#FLUX: --job-name=orchestra-executor
#FLUX: --exclusive
#FLUX: --priority=16

export MAESTRO_LOGPLACE='$pwd'
export LOGURO_LEVEL='INFO'

export MAESTRO_LOGPLACE=$pwd
echo "creating workdir..."
WORKDIR=$(mktemp -d)
echo $WORKDIR
cd $WORKDIR
echo "clonning..."
git clone https://github.com/jodafons/orchestra-server.git && cd orchestra-server
source dev_envs.sh
echo "building..."
make build_local
export LOGURO_LEVEL="INFO"
make node 
