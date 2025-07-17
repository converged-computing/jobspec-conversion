#!/bin/bash
#FLUX: --job-name=en_train
#FLUX: -c=20
#FLUX: --gpus-per-task=2
#FLUX: --queue=dev
#FLUX: -t=259200
#FLUX: --urgency=16

source /private/home/%u/.bashrc
conda deactivate
conda activate vlnce
module purge
module load cuda/10.1
module load cudnn/v7.6.5.32-cuda.10.1
module load NCCL/2.5.6-1-cuda.10.1
printenv | grep SLURM
set -x
srun -u \
python -u run.py \
    --exp-config vlnce_baselines/config/rxr_baselines/rxr_cma_en.yaml \
    --run-type train
