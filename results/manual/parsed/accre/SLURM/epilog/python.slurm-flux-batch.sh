#!/bin/bash
#FLUX: --job-name=salted-dog-9328
#FLUX: -t=600
#FLUX: --urgency=16

module load Anaconda2
srun --task-epilog=${SLURM_SUBMIT_DIR}/compress_large_files python vectorization.py
