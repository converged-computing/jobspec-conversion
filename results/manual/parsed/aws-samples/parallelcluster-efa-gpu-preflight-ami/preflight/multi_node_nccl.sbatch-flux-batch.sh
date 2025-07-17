#!/bin/bash
#FLUX: --job-name=placid-motorcycle-8673
#FLUX: -N=2
#FLUX: -n=192
#FLUX: --urgency=16

export NCCL_PROTO='simple'
export NCCL_DEBUG='INFO'
export FI_EFA_USE_DEVICE_RDMA='1 # use for p4dn'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_PROVIDER='efa'
export FI_EFA_ENABLE_SHM_TRANSFER='0'

NCCL_TEST_PATH=/tmp/nccl-tests/build
MPI_PATH=/opt/amazon/openmpi
export NCCL_PROTO=simple
export NCCL_DEBUG=INFO
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4dn
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_PROVIDER=efa
export FI_EFA_ENABLE_SHM_TRANSFER=0
$MPI_PATH/bin/mpirun --map-by ppr:8:node --rank-by slot \
    --mca pml ^cm  --mca btl tcp,self \
    --mca btl_tcp_if_exclude lo,docker0 --bind-to none \
    $NCCL_TEST_PATH/scatter_perf -b 8 -e 128 -f 2 -g 1 -c 1 -n 100
