#!/bin/bash
#FLUX: --job-name=pusheena-pedo-5530
#FLUX: -t=600
#FLUX: --priority=16

module load Anaconda2
srun --task-epilog=${SLURM_SUBMIT_DIR}/compress_large_files python vectorization.py
