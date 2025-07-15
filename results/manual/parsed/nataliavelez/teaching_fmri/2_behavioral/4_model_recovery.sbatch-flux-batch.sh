#!/bin/bash
#FLUX: --job-name=scruptious-squidward-9865
#FLUX: --urgency=16

module load ncf
module load Anaconda/5.0.1-fasrc01
source activate py3
python 4_model_recovery.py $1 ${SLURM_ARRAY_TASK_ID}
