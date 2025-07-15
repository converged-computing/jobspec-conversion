#!/bin/bash
#FLUX: --job-name=anxious-hippo-2981
#FLUX: -n=16
#FLUX: --queue=haswell
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
psc_frontend --apprun=../add.exe --mpinumprocs=1 --strategy=Importance --phase="mainRegion" --force-localhost
exit 0
