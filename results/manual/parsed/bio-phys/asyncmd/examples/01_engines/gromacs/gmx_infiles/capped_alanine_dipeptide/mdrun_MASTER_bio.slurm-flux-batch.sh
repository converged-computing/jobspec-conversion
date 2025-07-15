#!/bin/bash
#FLUX: --job-name=gassy-underoos-4186
#FLUX: -c=2
#FLUX: --queue=s.bio
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MPI_NUM_RANKS='$SLURM_NTASKS_PER_NODE'
export OMP_PLACES='cores  ## with enabled hyperthreading this line needs to be commented out'

source ~/sources/asyncmd_dev_modules.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPI_NUM_RANKS=$SLURM_NTASKS_PER_NODE
export OMP_PLACES=cores  ## with enabled hyperthreading this line needs to be commented out
srun {mdrun_cmd}
