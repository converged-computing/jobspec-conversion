#!/bin/bash
#FLUX: --job-name=butterscotch-lamp-2119
#FLUX: -c=7
#FLUX: --queue=small-g
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module use /appl/local/csc/modulefiles
module load gromacs/2023.3-gpu
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun gmx_mpi mdrun -g ex1.1_${SLURM_NTASKS}x${OMP_NUM_THREADS}_jID${SLURM_JOB_ID} \
                   -nsteps -1 -maxh 0.017 -resethway -notunepme
