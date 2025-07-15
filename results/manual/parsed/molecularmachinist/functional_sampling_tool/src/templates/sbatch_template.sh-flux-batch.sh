#!/bin/bash
#FLUX: --job-name=angry-leader-8459
#FLUX: -N=20
#FLUX: --queue=medium
#FLUX: -t=129600
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OMP_PLACES='cores'

module load gcc/9.4.0
module load openmpi/4.1.2
module load gromacs/2020.5
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=cores
srun gmx_mpi mdrun  -deffnm mdrun -multidir rep* -maxh 36
