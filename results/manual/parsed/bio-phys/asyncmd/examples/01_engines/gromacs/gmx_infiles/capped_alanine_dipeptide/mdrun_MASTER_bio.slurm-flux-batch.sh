#!/bin/bash
#FLUX: --job-name=red-buttface-9441
#FLUX: -c=2
#FLUX: --queue=s.bio  ## makes sure you run on the s. partition where left over resources of a node can be filled by other jobs
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MPI_NUM_RANKS='$SLURM_NTASKS_PER_NODE'
export OMP_PLACES='cores  ## with enabled hyperthreading this line needs to be commented out'

source ~/sources/asyncmd_dev_modules.sh
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MPI_NUM_RANKS=$SLURM_NTASKS_PER_NODE
export OMP_PLACES=cores  ## with enabled hyperthreading this line needs to be commented out
srun {mdrun_cmd}
