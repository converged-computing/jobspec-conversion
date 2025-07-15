#!/bin/bash
#FLUX: --job-name=waypoint_train
#FLUX: -N=8
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=dev
#FLUX: -t=259200
#FLUX: --priority=16

source /private/home/%u/.bashrc
conda deactivate
conda activate vlnce
MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
export MASTER_ADDR
module purge
module load cuda/10.1
module load cudnn/v7.6.5.32-cuda.10.1
module load NCCL/2.5.6-1-cuda.10.1
printenv | grep SLURM
set -x
srun -u \
python -u run.py \
    --exp-config vlnce_baselines/config/r2r_waypoint/2-wpn-dc.yaml \
    --run-type train
