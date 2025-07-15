#!/bin/bash
#FLUX: --job-name=bumfuzzled-egg-0677
#FLUX: -t=18000
#FLUX: --urgency=16

module load cuda
cd $SLURM_SUBMIT_DIR
nvidia-smi
