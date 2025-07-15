#!/bin/bash
#FLUX: --job-name=auto-vscode
#FLUX: --queue=gpu
#FLUX: -t=259199
#FLUX: --urgency=16

module purge
module load miniconda/3
echo $SLURM_ARRAY_TASK_ID
yml=$(head -n $SLURM_ARRAY_TASK_ID batch_ymls.txt | tail -n 1) 
python -u eit.py $yml
