#!/bin/bash
#FLUX: --job-name=gromacs-threadmpi
#FLUX: --exclusive
#FLUX: --priority=16

NTOMP=1
mkdir -p /shared-non-cache/output/jobs/${SLURM_JOBID}
cd /shared-non-cache/output/jobs/${SLURM_JOBID}
spack load gromacs
module load openmpi
set -x
time mpirun -np ${SLURM_NTASKS} gmx_mpi mdrun -ntomp ${NTOMP} -s /shared-cache/input/gromacs/benchRIB.tpr -resethway
