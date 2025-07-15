#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: --urgency=16

export MPI_FLAGS='--tag-output --bind-to socket -map-by core -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1'
export MASTER_ADDR='$(hostname -s)'
export MASTER_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')'

module load anaconda/2023a
module load mpi/openmpi-4.1.3
module load cuda/11.6
module load nccl/2.11.4-cuda11.6
export MPI_FLAGS="--tag-output --bind-to socket -map-by core -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1"
export MASTER_ADDR=$(hostname -s)
export MASTER_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "MASTER_ADDR : ${MASTER_ADDR}"
echo "MASTER_PORT : ${MASTER_PORT}"
mpirun ${MPI_FLAGS} python torch_test.py
