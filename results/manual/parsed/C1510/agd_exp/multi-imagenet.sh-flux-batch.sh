#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: -N=4
#FLUX: -c=20
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'
export MPI_FLAGS='--tag-output --bind-to socket -map-by core -mca btl ^openib -mca pml ob1 -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1'
export MASTER_ADDR='$(hostname -s)'
export MASTER_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')'
export IMAGENET_PATH='/home/gridsan/groups/datasets/ImageNet'

source /etc/profile
module load anaconda/2021a
module load cuda/10.1
module load mpi/openmpi-4.0
module load nccl/2.5.6-cuda10.1
export OMP_NUM_THREADS=20
export MPI_FLAGS="--tag-output --bind-to socket -map-by core -mca btl ^openib -mca pml ob1 -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1"
export MASTER_ADDR=$(hostname -s)
export MASTER_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "MASTER_ADDR : ${MASTER_ADDR}"
echo "MASTER_PORT : ${MASTER_PORT}"
export IMAGENET_PATH=/home/gridsan/groups/datasets/ImageNet
mpirun ${MPI_FLAGS} python main.py --distribute --train_bs 1024 --test_bs 1024 --arch resnet50 --dataset imagenet --epochs 500 --loss xent
