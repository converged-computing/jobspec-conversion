#!/bin/bash
#FLUX: --job-name=tom_childsum
#FLUX: -c=3
#FLUX: --queue=gpu_shared_course
#FLUX: -t=2700
#FLUX: --urgency=16

module purge
module load 2019
module load Python/3.7.5-foss-2019b
module load CUDA/10.1.243
module load cuDNN/7.6.5.32-CUDA-10.1.243
module load NCCL/2.5.6-CUDA-10.1.243
module load Anaconda3/2018.12
cd $HOME/nlp1_uva/lab_2/
source activate dl2020
HPARAMS_FILE=./lisa_params/childsum_hparams.txt
srun python3 -u train.py $(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1)
