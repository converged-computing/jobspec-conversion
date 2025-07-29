#!/bin/bash
#FLUX: --job-name=gmx
#FLUX: -c=2
#FLUX: --queue=cn
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module purge
module load gromacs/2021/2021.4-intel-nogpu-openmpi-gcc
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
mpirun gmx_mpi mdrun -ntomp ${SLURM_CPUS_PER_TASK} -v -s benchMEM.tpr
