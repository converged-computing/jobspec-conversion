#!/bin/bash
#FLUX: --job-name=dinosaur-puppy-9197
#FLUX: --urgency=16

module purge
module load PrgEnv-cray
module load cmake
module list
pwd
date
ls -lh
echo '*** Starting Parallel Job ***'
srun -n $SLURM_NTASKS ./short_pulse.Linux
date
echo '*** All Done ***'
