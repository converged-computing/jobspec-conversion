#!/bin/bash
#FLUX: --job-name=srgan
#FLUX: -N=4
#FLUX: -c=48
#FLUX: --queue=ce-mri
#FLUX: -t=172800
#FLUX: --priority=16

export NCCL_P2P_DISABLE='1  # IN AMD+A100 cluster'
export MASTER_PORT='$(((RANDOM % 1000 + 5000)))'

export NCCL_P2P_DISABLE=1  # IN AMD+A100 cluster
export MASTER_PORT=$(((RANDOM % 1000 + 5000)))
num_gpus=$(nvidia-smi --list-gpus | wc -l)
now=$(date +'%b%d-%H')
experiment_name=$1
if [ -z $experiment_name ]; then
  job_dir=runs/train_${now}
else
  job_dir=runs/train_${experiment_name}_${now}
fi
if [ -d "runs/$job_dir" ]; then
    printf '%s\n' "Removing $job_dir"
    rm -rf $job_dir
fi
printf '%s\n' "Training on GPU ${CUDA_VISIBLE_DEVICES}"
srun python -m torch.distributed.run  --nproc_per_node $num_gpus --master_port $MASTER_PORT train.py
