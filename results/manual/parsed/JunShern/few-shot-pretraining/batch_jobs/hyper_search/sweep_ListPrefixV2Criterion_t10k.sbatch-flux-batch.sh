#!/bin/bash
#FLUX: --job-name=hyper_job
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --priority=16

module purge
module load anaconda3/2020.07
source ~/.bashrc
conda activate alignment
myquota
nvidia-smi
which python
wandb login
cd $HOME/git/few-shot-pretraining
echo SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_ID
wandb agent --count 1 junshern/alignment_pretraining/oiro6rwh
