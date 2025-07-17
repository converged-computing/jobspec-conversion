#!/bin/bash
#FLUX: --job-name=an-pinn-test-relo
#FLUX: --queue=plgrid-gpu-v100
#FLUX: -t=18000
#FLUX: --urgency=16

module load cuda
cd $SLURM_SUBMIT_DIR
nvidia-smi
