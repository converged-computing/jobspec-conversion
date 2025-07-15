#!/bin/bash
#FLUX: --job-name=RUN_MULTGPU_DDP
#FLUX: -t=57600
#FLUX: --priority=16

module purge
module load python
module load cuda
module load cudnn
module load nccl
source ~/miniconda3/bin/activate ili-sbi
master_node=$SLURMD_NODENAME
cd /mnt/home/spandey/ceph/CHARFORMER/src/
srun python `which torchrun` \
        --nnodes $SLURM_JOB_NUM_NODES \
        --nproc_per_node $SLURM_GPUS_PER_NODE \
        --rdzv_id $SLURM_JOB_ID \
        --rdzv_backend c10d \
        --rdzv_endpoint $master_node:29500 \
        test_ddp.py
echo "done"
