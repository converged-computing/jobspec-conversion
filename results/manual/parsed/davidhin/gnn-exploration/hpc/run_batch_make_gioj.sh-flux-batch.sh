#!/bin/bash
#FLUX: --job-name=make_gioj
#FLUX: -n=4
#FLUX: --queue=batch
#FLUX: -t=1200
#FLUX: --urgency=16

module load Singularity
module load CUDA/10.2.89
singularity run main.simg -p gnnproject/analysis/run_batch_make_gioj.py -a $SLURM_ARRAY_TASK_ID
