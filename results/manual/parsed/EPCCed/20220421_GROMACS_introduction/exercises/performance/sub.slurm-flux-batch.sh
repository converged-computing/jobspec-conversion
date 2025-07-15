#!/bin/bash
#FLUX: --job-name=GMX_test
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gromacs
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun -n 1 \
  gmx_mpi mdrun -ntomp ${SLURM_CPUS_PER_TASK} -nsteps 10000 -s npt.tpr
