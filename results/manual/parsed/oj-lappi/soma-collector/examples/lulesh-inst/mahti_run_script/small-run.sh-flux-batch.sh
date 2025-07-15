#!/bin/bash
#FLUX: --job-name=soma-symbiomon
#FLUX: -N=2
#FLUX: --queue=medium
#FLUX: -t=7200
#FLUX: --urgency=16

export SOMA_SERVER_ADDR_FILE='`pwd`/server.add'
export SOMA_NODE_ADDR_FILE='`pwd`/node.add'
export SOMA_NUM_SERVER_INSTANCES='1'
export SOMA_NUM_SERVERS_PER_INSTANCE='8'
export SOMA_SERVER_INSTANCE_ID='0'
export LD_LIBRARY_PATH='`pkg-config --libs-only-L soma-client soma-server soma-admin | sed -e "s/ -L/:/g" | sed -e "s/-L//g" | sed -e "s/ //g"`:`spack location -i conduit`/lib:$LD_LIBRARY_PATH'

set -eu
echo "Setting up spack and modules"
source /users/sriamesh/spack/share/spack/setup-env.sh
cd /users/sriamesh/SOMA/soma-collector
spack env activate . 
spack load mochi-bedrock
spack load conduit
cd build/examples
cd /users/sriamesh/SOMA/soma-collector/examples/lulesh-inst/mahti_run_script
echo "Starting SOMA Collectors..."
export SOMA_SERVER_ADDR_FILE=`pwd`/server.add
export SOMA_NODE_ADDR_FILE=`pwd`/node.add
export SOMA_NUM_SERVER_INSTANCES=1
export SOMA_NUM_SERVERS_PER_INSTANCE=8
export SOMA_SERVER_INSTANCE_ID=0
srun -n 8 -N 1 /users/sriamesh/SOMA/soma-collector/build/examples/example-server -a ofi+verbs:// &
sleep 10
export LD_LIBRARY_PATH=`pkg-config --libs-only-L soma-client soma-server soma-admin | sed -e "s/ -L/:/g" | sed -e "s/-L//g" | sed -e "s/ //g"`:`spack location -i conduit`/lib:$LD_LIBRARY_PATH
echo "Starting LULESH"
cp ../lulesh2.0 .
srun -n 8 -N 1 ./lulesh2.0 -i 500 -p
