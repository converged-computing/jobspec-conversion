#!/bin/bash
#FLUX: --job-name=A20-k1-ginf-l3
#FLUX: -c=128
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PLACES='threads'
export OMP_BIND_PROC='true'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=threads
export OMP_BIND_PROC=true
ml amd-modules
srun ball0x.exe > log.out 2> err.out 
