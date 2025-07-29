#!/bin/bash
#FLUX: --job-name=soma-symbiomon
#FLUX: --queue=medium
#FLUX: -t=7200
#FLUX: --urgency=16

export SOMA_SERVER_ADDR_FILE='`pwd`/server.add'
export SOMA_NODE_ADDR_FILE='`pwd`/node.add'
export SOMA_NUM_SERVER_INSTANCES='1'
export SOMA_NUM_SERVERS_PER_INSTANCE='2'
export LD_LIBRARY_PATH='`pkg-config --libs-only-L soma-client soma-server soma-admin | sed -e "s/ -L/:/g" | sed -e "s/-L//g" | sed -e "s/ //g"`:`spack location -i conduit`/lib:$LD_LIBRARY_PATH'
export SOMA_SERVER_INSTANCE_ID='0'

set -eu
echo "Setting up spack and modules"
source /projappl/project_2006549/spack/share/spack/setup-env.sh
cd /users/dewiy/soma-collector
spack env activate . 
spack load mochi-bedrock
spack load conduit
cd build/examples
cd /users/dewiy/soma-collector/examples/lulesh/mahti_run_script
echo "Starting SOMA Collectors..."
export SOMA_SERVER_ADDR_FILE=`pwd`/server.add
export SOMA_NODE_ADDR_FILE=`pwd`/node.add
export SOMA_NUM_SERVER_INSTANCES=1
export SOMA_NUM_SERVERS_PER_INSTANCE=2
srun -n 2 -N 1 /users/dewiy/soma-collector/build/examples/example-server -a ofi+verbs:// &
sleep 10
export LD_LIBRARY_PATH=`pkg-config --libs-only-L soma-client soma-server soma-admin | sed -e "s/ -L/:/g" | sed -e "s/-L//g" | sed -e "s/ //g"`:`spack location -i conduit`/lib:$LD_LIBRARY_PATH
echo "Starting LULESH"
export SOMA_SERVER_INSTANCE_ID=0
cp ../lulesh2.0 .
srun -n 8 -N 1 ./lulesh2.0 -i 500 -p
