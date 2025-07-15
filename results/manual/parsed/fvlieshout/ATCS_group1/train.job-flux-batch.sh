#!/bin/bash
#FLUX: --job-name=roberta_job
#FLUX: -c=6
#FLUX: --queue=gpu_shared_course
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
cd $HOME/ATCS_group1
source activate gnn-env
PARAMETERS_FILE=parameters.txt
srun python -u train.py $(head -$SLURM_ARRAY_TASK_ID $PARAMETERS_FILE | tail -1)
