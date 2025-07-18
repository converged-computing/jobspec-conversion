#!/bin/bash
#FLUX: --job-name=pytorch
#FLUX: -N=2
#FLUX: -c=12
#FLUX: --urgency=16

export MPI_FLAGS='--tag-output --bind-to socket -map-by core -mca btl ^openib -mca pml ob1 -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1'
export NCCL_IB_DISABLE='1'
export NCCL_DEBUG='INFO'
export MASTER_ADDR='$(hostname -s)'
export MASTER_PORT='$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')'

source /etc/profile
module load anaconda/2021a
module load mpi/openmpi-4.1.1
export MPI_FLAGS="--tag-output --bind-to socket -map-by core -mca btl ^openib -mca pml ob1 -x PSM2_GPUDIRECT=1 -x NCCL_NET_GDR_LEVEL=5 -x NCCL_P2P_LEVEL=5 -x NCCL_NET_GDR_READ=1"
export NCCL_IB_DISABLE=1
export NCCL_DEBUG=INFO
rank=${1-"0"}
nnodes=${2-"2"}
port=${3-"52111"}
addr=${4-"d-10-10-1"} 
pretrained=${5-" ss"}
num_user=${6-"40"} 
frac=${7-"0.25"}
local_ep=${8-"3"}
skew=${9-"0"}
total_ep=${10-"100"}
export MASTER_ADDR=$(hostname -s)
export MASTER_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
echo "MASTER_ADDR : ${MASTER_ADDR}"
echo "MASTER_PORT : ${MASTER_PORT}"
echo "${0} ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9}"
mpirun ${MPI_FLAGS}  python \
 src/decentralized_sl_main.py --distributed_training  --model=resnet --dataset=imagenet100  --gpu=0 --iid=1 --batch_size=256 --local_bs 256 --local_ep ${local_ep} --epochs=${total_ep} --log_file_name "imagenet100_sl" \
									   --average_without_bn  --lr 0.005 --optimizer adam --full_size --backbone resnet18 --batch_size 256 --num_users ${num_user}  \
									   --frac ${frac}  --model_continue_training 1 --y_partition_skew --y_partition_ratio ${skew} --log_directory "imagenet100_scripts"  --load_pretrained_path ${pretrained} \
									   --script_name "${0} ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8} ${9} ${10}" --load_dataset_to_memory  
