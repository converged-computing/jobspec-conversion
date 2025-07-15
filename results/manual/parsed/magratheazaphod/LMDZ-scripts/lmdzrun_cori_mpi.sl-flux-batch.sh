#!/bin/bash
#FLUX: --job-name=anxious-muffin-5106
#FLUX: --priority=16

module swap PrgEnv-intel PrgEnv-gnu
cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
srun -n 24 ./gcm.e
