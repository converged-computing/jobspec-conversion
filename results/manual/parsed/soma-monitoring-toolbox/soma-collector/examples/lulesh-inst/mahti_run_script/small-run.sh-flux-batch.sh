#!/bin/bash
#FLUX: --job-name=soma-lulesh
#FLUX: -N=2
#FLUX: --queue=medium
#FLUX: -t=1200
#FLUX: --urgency=16

export SOMA_SERVER_ADDR_FILE='`pwd`/server.add'
export SOMA_NODE_ADDR_FILE='`pwd`/node.add'
export SOMA_NUM_SERVER_INSTANCES='1'
export SOMA_NUM_SERVERS_PER_INSTANCE='1'
export SOMA_SERVER_INSTANCE_ID='0'

set -eu
module load gcc/9.4.0 openmpi/4.1.2-cuda cmake
echo "Starting SOMA Collectors..."
export SOMA_SERVER_ADDR_FILE=`pwd`/server.add
export SOMA_NODE_ADDR_FILE=`pwd`/node.add
export SOMA_NUM_SERVER_INSTANCES=1
export SOMA_NUM_SERVERS_PER_INSTANCE=1
export SOMA_SERVER_INSTANCE_ID=0
srun -n 1 -N 1 /users/dewiy/soma-collector/build/examples/example-server -a ofi+verbs:// &
sleep 10
echo "Starting LULESH"
srun -n 8 -N 1 /users/dewiy/soma-collector/build/examples/lulesh-inst/lulesh2.0 -i 500 -p
