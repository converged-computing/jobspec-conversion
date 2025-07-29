#!/bin/bash
#FLUX: --job-name=ring_shift_blocking
#FLUX: -N=2
#FLUX: -t=2400
#FLUX: --urgency=16

module purge
module load intel/2020a
module load CMake/3.16.4
cd $SLURM_SUBMIT_DIR                    ### change to the directory where your code is located
chmod +x ./scripts/run_ringshift.sh
./scripts/run_ringshift.sh "results/part3_ringshift.csv"
scontrol show job $SLURM_JOB_ID         ### write job information to output file
