#!/bin/bash
#FLUX: --job-name=LMDZ_RUN
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

module swap PrgEnv-intel PrgEnv-gnu
cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
srun -n 24 ./gcm.e
