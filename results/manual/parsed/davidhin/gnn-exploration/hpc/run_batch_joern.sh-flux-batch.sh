#!/bin/bash
#FLUX: --job-name=batch_joern
#FLUX: -t=1200
#FLUX: --urgency=16

module load Singularity
module load CUDA/10.2.89
singularity run main.simg -p gnnproject/analysis/run_batch_joern.py -a $SLURM_ARRAY_TASK_ID
