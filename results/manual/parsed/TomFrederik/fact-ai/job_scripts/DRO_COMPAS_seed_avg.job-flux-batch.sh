#!/bin/bash
#FLUX: --job-name=DRO_compas_seed_avg
#FLUX: -c=6
#FLUX: --queue=gpu_shared_course
#FLUX: -t=16200
#FLUX: --priority=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
cd $HOME/fact-ai/
source activate fact-ai-lisa
HPARAMS_FILE=./job_scripts/hparams/DRO_COMPAS.txt
srun python -u main.py $(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1)
