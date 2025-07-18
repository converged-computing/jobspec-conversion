#!/bin/bash
#FLUX: --job-name=nerdy-cherry-0871
#FLUX: -c=32
#FLUX: --queue=small-g
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module use /appl/local/csc/modulefiles
module load gromacs/2023.3-gpu
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
srun gmx_mpi mdrun -g ex1.3_${SLURM_NTASKS}x${OMP_NUM_THREADS}_jID${SLURM_JOB_ID} \
                   -nsteps -1 -maxh 0.017 -resethway -notunepme
