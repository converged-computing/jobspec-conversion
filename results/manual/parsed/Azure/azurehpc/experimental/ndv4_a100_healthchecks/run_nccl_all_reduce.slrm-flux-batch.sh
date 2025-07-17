#!/bin/bash
#FLUX: --job-name=crunchy-parsnip-1784
#FLUX: -c=12
#FLUX: -t=300
#FLUX: --urgency=16

export UCX_IB_PCI_RELAXED_ORDERING='on \'

export UCX_IB_PCI_RELAXED_ORDERING=on \
       CUDA_DEVICE_ORDER=PCI_BUS_ID \
       NCCL_DEBUG=WARN \
       NCCL_IB_PCI_RELAXED_ORDERING=1 \
       NCCL_TOPO_FILE=/opt/microsoft/ndv4-topo.xml \
       NCCL_SOCKET_IFNAME=eth0 \
       UCX_NET_DEVICES=eth0 \
       OMPI_MCA_coll_hcoll_enable=0 \
       LD_LIBRARY_PATH=/usr/local/nccl_rdma_sharp_plugins/lib:$LIBRARY_PATH
PIN_MASK='ffffff000000,ffffff000000,ffffff,ffffff,ffffff000000000000000000,ffffff000000000000000000,ffffff000000000000,ffffff000000000000'
source /etc/profile.d/modules.sh
module load mpi/hpcx
EXE_DIR=/opt/nccl-tests/build
srun --mpi=pmix --cpu-bind=mask_cpu:$PIN_MASK \
     ${BASE_DIR}/nccl-tests/build/all_reduce_perf -b 4G -f 2 -g 1 -c 1 -e 8G
