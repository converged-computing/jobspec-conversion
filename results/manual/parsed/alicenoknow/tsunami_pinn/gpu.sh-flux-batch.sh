#!/bin/bash
#FLUX: --job-name=moolicious-signal-4045
#FLUX: -t=18000
#FLUX: --priority=16

module load cuda
cd $SLURM_SUBMIT_DIR
nvidia-smi
