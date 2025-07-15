#!/bin/bash
#FLUX: --job-name=red-peanut-3887
#FLUX: -n=16
#FLUX: --queue=haswell
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

SCOREP_ENABLE_PROFILING=true
SCOREP_ENABLE_TRACING=false
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
psc_frontend --apprun=../add.exe --mpinumprocs=1 --tune=mpicap --phase="mainRegion" --force-localhost
exit 0
