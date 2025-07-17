#!/bin/bash
#FLUX: --job-name=vtf
#FLUX: -c=10
#FLUX: --queue=learnfair
#FLUX: -t=259200
#FLUX: --urgency=16

export MASTER_ADDR='${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}'
export MASTER_PORT='19500'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export NCCL_SOCKET_IFNAME='^docker0,lo'

module load anaconda3
source activate motionformer
export MASTER_ADDR=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
export MASTER_PORT=19500
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export NCCL_SOCKET_IFNAME=^docker0,lo
echo $SLURMD_NODENAME $SLURM_JOB_ID $CUDA_VISIBLE_DEVICES
master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
echo $dist_url
if [ -z "$1" ]
then
	CFG='configs/K400/joint_224_16x4.yaml'
else
	CFG=$1
fi
if [ -z "$2" ]
then
	ROOT_FOLDER="/checkpoint/motionformer"
else
	ROOT_FOLDER=$2
fi
SAV_FOLDER="${ROOT_FOLDER}/${SLURM_JOB_ID}"
mkdir -p ${SAV_FOLDER}
srun --label python tools/run_net.py --init_method $dist_url --num_shards 1 --cfg $CFG \
NUM_GPUS 8 \
OUTPUT_DIR ${SAV_FOLDER} \
