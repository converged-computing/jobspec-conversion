#!/bin/bash
#FLUX --job-name=strawberry-truffle-0649
#FLUX -t=600
#FLUX --urgency=16

module load Anaconda2
srun --task-epilog=${SLURM_SUBMIT_DIR}/compress_large_files python vectorization.py
