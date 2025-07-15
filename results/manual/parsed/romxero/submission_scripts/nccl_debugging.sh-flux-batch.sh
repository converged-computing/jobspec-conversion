#!/bin/bash
#FLUX: --job-name=relion_test
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=2
#FLUX: --gpus-per-task=1
#FLUX: --queue=cpu
#FLUX: -t=300
#FLUX: --priority=16

export NCCL_DEBUG='WARN'
export PYTHONFAULTHANDLER='1'
export NCCL_IB_PCI_RELAXED_ORDERING='0'
export CUDA_DEVICE_ORDER='PCI_BUS_ID'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_TOPO_FILE='/opt/microsoft/ndv4-topo.xml'
export MPI_HOME='/hpc/apps/openmpi/4.1.6'
export CUDA_HOME='/hpc/apps/x86_64/cuda/12.2.1_535.86.10'
export NCCL_HOME='/hpc/apps/x86_64/nvhpc-sdk/23.11/Linux_x86_64/23.11/comm_libs/nccl'
export TESTS_ARRAY='( all_reduce_perf broadcast_perf reduce_perf all_gather_perf all_reduce_sum_perf reduce_scatter_perf broadcast_recv_perf reduce_recv_perf all_gather_recv_perf reduce_scatter_recv_perf )'
export OMPI_MCA_btl='^openib'

ml purge 
ml load openmpi/4.1.6 cuda/12.2.1_535.86.10 nvhpc-sdk/23.11
export NCCL_DEBUG=WARN
export PYTHONFAULTHANDLER=1
export NCCL_IB_PCI_RELAXED_ORDERING=0
export CUDA_DEVICE_ORDER=PCI_BUS_ID
export NCCL_SOCKET_IFNAME=ib0
export NCCL_TOPO_FILE=/opt/microsoft/ndv4-topo.xml
export MPI_HOME=/hpc/apps/openmpi/4.1.6
export CUDA_HOME=/hpc/apps/x86_64/cuda/12.2.1_535.86.10
export NCCL_HOME=/hpc/apps/x86_64/nvhpc-sdk/23.11/Linux_x86_64/23.11/comm_libs/nccl
export TESTS_ARRAY=( all_reduce_perf broadcast_perf reduce_perf all_gather_perf all_reduce_sum_perf reduce_scatter_perf broadcast_recv_perf reduce_recv_perf all_gather_recv_perf reduce_scatter_recv_perf )
export OMPI_MCA_btl="^openib"
if ! [ -d nccl-tests ]; then
git clone https://github.com/NVIDIA/nccl-tests.git
cd nccl-tests
fi
make MPI=1 
for TEST in ${TESTS_ARRAY[@]}; do
    echo "Running test: ${TEST}"
    srun -np 4 ./build/${TEST} 
done
exit 0 
